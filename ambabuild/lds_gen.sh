#!/bin/bash
#
# The script adds .cvtask_init_table into default linker script
# $1: "ld" of the desired toolchain
# $2: target linker script file path
#

INIT_SECT="
	. = ALIGN(32);
	__cvtask_init_start = .;
	KEEP(* (.cvtask_create_fp*))
	__cvtask_init_end = .;
"

FMT_SECT="
	.cvtask_formats :
	{
		. = ALIGN(0x80); PROVIDE (__cvtask_format_start = .);
		KEEP (*(.cvtask_format .cvtask_format*))
		. = ALIGN(0x80); PROVIDE (__cvtask_format_end = .);
	}
"

TF0=tmp.lds.0
TF1=tmp.lds.1
TF2=tmp.lds.2

$1 -verbose > $TF0
line=($(grep -n '=========' $TF0 | cut -d ":" -f 1))
tail -n +$((${line[0]}+1)) $TF0 | head -n -1 > $TF1

line=$(grep -n '(\.gnu\.warning)' $TF1 | cut -d ":" -f 1)
{ head -n ${line} $TF1; echo "${INIT_SECT}"; tail -n +$((${line}+1)) $TF1; } > $TF2

line=$(grep -n '(\.rodata1' $TF2 | cut -d ":" -f 1)
{ head -n ${line} $TF2; echo "${FMT_SECT}"; tail -n +$((${line}+1)) $TF2; } > $2

if [ "${PROJECT}" == "cv6" ] && [ "${AMBACV_KERNEL_SUPPORT}" == "y" ]; then
	sed -i -e 's|"text-segment", 0x400000|"text-segment", 0x000000|g' $2
fi

rm $TF0 $TF1 $TF2
