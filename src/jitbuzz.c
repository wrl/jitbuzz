#include <stdint.h>
#include <stdio.h>

#include <sljitLir.h>

const char *fmt[] = {
	"%d\n",
	"fizz\n",
	"buzz\n",
	"fizzbuzz\n"
};

int
main(void)
{
	void (*fizzbuzz)();
	uint32_t i, d;

	struct sljit_compiler *c = sljit_create_compiler(NULL);

	sljit_emit_enter(c, 0, 0, 2, 0, 0, 0, 0);

	for (i = 0; i < 101; i++) {
		d = ((!(i % 3))
		  | ((!(i % 5)) << 1))
			& (!i - 1);

		sljit_emit_op1(c, SLJIT_MOV, SLJIT_R0, 0, SLJIT_MEM, (sljit_p) &fmt[d]);

		if (d) {
			sljit_emit_icall(c, SLJIT_CALL, SLJIT_ARG1(SW),
					SLJIT_IMM, SLJIT_FUNC_OFFSET(printf));
		} else {
			sljit_emit_op1(c, SLJIT_MOV, SLJIT_R1, 0, SLJIT_IMM, i);
			sljit_emit_icall(c, SLJIT_CALL, SLJIT_ARG1(SW) | SLJIT_ARG2(SW),
					SLJIT_IMM, SLJIT_FUNC_OFFSET(printf));
		}
	}

	sljit_emit_return(c, SLJIT_MOV, SLJIT_R0, 0);

	fizzbuzz = sljit_generate_code(c);
	sljit_free_compiler(c);

	fizzbuzz();

	sljit_free_code(fizzbuzz);

	return 0;
}
