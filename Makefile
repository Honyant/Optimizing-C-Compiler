
B=build

ARM_QEMU=~gheith/public/qemu_5.1.0_old/bin/qemu-aarch64
ARM_GCC=~gheith/public/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc


CXX=g++
CXX_FLAGS=-Wall -Werror -std=c++17 -g
CC=cc
CC_FLAGS=-Wall -Werror -std=c99


CXX_FILES=${wildcard *.cxx}
CXX_O_FILES=${addprefix $B/,${subst .cxx,.o,${CXX_FILES}}}

C_FILES=${wildcard *.c}
C_O_FILES=${addprefix $B/,${subst .c,.o,${C_FILES}}}

LINK=${firstword ${patsubst %.cxx,${CXX},${CXX_FILES} ${patsubst %.c,${CC},${C_FILES}}}}
LINK_FLAGS=

TEST_DIR=../cs429h_s24_p4__tests
FUN_FILES=$(wildcard *.fun) $(wildcard $(TEST_DIR)/*.fun)
# FUN_FILES=${sort ${wildcard *.fun}}
TESTS=${subst .fun,.test,${FUN_FILES}}
OK_FILES=${subst .fun,.ok,${FUN_FILES}}
OUT_FILES=${subst .fun,.out,${FUN_FILES}}
DIFF_FILES=${subst .fun,.diff,${FUN_FILES}}
RESULT_FILES=${subst .fun,.result,${FUN_FILES}}
ASM_FILES=${subst .fun,.s,${FUN_FILES}}
ARM_FILES=${subst .fun,.arm,${FUN_FILES}}
ARGS_FILES=${subst .fun,.args,${FUN_FILES}}

all : $B/funcc

test : Makefile ${TESTS}

$B/funcc: ${CXX_O_FILES} ${C_O_FILES}
	@mkdir -p $B
	${LINK} -o $@ ${LINK_FLAGS} ${CXX_O_FILES} ${C_O_FILES}

${CXX_O_FILES} : $B/%.o: %.cxx Makefile
	@mkdir -p $B
	${CXX} -MMD -MF $B/$*.d -c -o $@ ${CXX_FLAGS} $*.cxx

${C_O_FILES} : $B/%.o: %.c Makefile
	@mkdir -p $B
	${CC} -MMD -MF $B/$*.d -c -o $@ ${CC_FLAGS} $*.c

${TESTS}: %.test : Makefile %.result
	echo "$* ... $$(cat $*.result) [$$(cat $*.time)]"

${RESULT_FILES}: %.result : Makefile %.diff
	echo "unknown" > $@
	-((test -s $*.diff && echo "fail") || echo "pass") > $@


${DIFF_FILES}: %.diff : Makefile %.out %.ok
	@echo "no diff" > $@
	-diff $*.out $*.ok > $@ 2>&1

${ASM_FILES}: %.s : Makefile $B/funcc %.fun
	@echo "failed to run" > $@
	-timeout 10 $B/funcc $*.fun > $@

${ARM_FILES}: %.arm : Makefile %.s
	@echo "failed to run" > $@
	-${ARM_GCC} -static -g -o $*.arm $*.s

${OUT_FILES}: %.out : Makefile %.arm %.args
	@echo "failed to run" > $@
	-time --quiet -f '%e' -o $*.time timeout 10 ${ARM_QEMU} ./$*.arm `cat $*.args` > $@

-include $B/*.d

clean:
	rm -rf $B
	rm -f *.diff *.result *.out *.time *.s *.arm
	rm -f ${TEST_DIR}/*.diff ${TEST_DIR}/*.result ${TEST_DIR}/*.out ${TEST_DIR}/*.time