#! perl -w

use Parrot::Test tests => 1;

TODO: {
    local $TODO="t/src doesn't work on Windows" if $^O =~ /Win32/;
    $TODO=$TODO;  #warnings

    c_output_is(<<'CODE', <<'OUTPUT', "hello world");
        #include <stdio.h>
        #include "parrot/parrot.h"
        #include "parrot/embed.h"

        int main(int argc, char* argv[]) {
	        int dummy_var;
	        STRING *S;
	        PMC *pmc;
            INTVAL ival;
            UINTVAL uval;
            float fval;
            double dval;
            FLOATVAL fltval;
            char *fmt;
	        struct Parrot_Interp * interpreter;

	        interpreter = Parrot_new();
	        Parrot_init(interpreter, (void*) &dummy_var);

	        S = Parrot_sprintf_c(interpreter, "Hello, %s\n", "Parrot!");
	        printf(string_to_cstring(interpreter, S));
	        
	        S = Parrot_sprintf_c(interpreter, "PerlHash[0x%x]\n", 256);
	        printf(string_to_cstring(interpreter, S));
	        
	        S = Parrot_sprintf_c(interpreter, "PerlHash[0x%lx]\n", 256);
	        printf(string_to_cstring(interpreter, S));
	        
	        S = Parrot_sprintf_c(interpreter, "Hello, %.2s!\n", "Parrot");
	        printf(string_to_cstring(interpreter, S));
	        
	        S = Parrot_sprintf_c(interpreter, "Hello, %Ss", S);
	        printf(string_to_cstring(interpreter, S));
	        
            pmc=pmc_new(interpreter, enum_class_PerlInt);
            pmc->vtable->set_integer_native(interpreter, pmc, 1);	        
	        S = Parrot_sprintf_c(interpreter, "== %Pd\n", pmc);
	        printf("%d %s", 1, string_to_cstring(interpreter, S));

		    ival = -255;
	        S = Parrot_sprintf_c(interpreter, "== %vd\n", ival);
	        printf("%d %s", (int) ival, string_to_cstring(interpreter, S));
		
		    uval = 256;
	        S = Parrot_sprintf_c(interpreter, "== %vu\n", uval);
	        printf("%u %s", (unsigned) uval,  string_to_cstring(interpreter, S));

		    fval = 0.5;
	        S = Parrot_sprintf_c(interpreter, "== %f\n", fval);
	        printf("%f %s", fval, string_to_cstring(interpreter, S));
		
		    dval = 0.5;
	        S = Parrot_sprintf_c(interpreter, "== %5.3f\n", dval);
	        printf("%5.3f %s", dval, string_to_cstring(interpreter, S));
		
		    dval = 0.001;
	        S = Parrot_sprintf_c(interpreter, "== %g\n", dval);
	        printf("%g %s", dval, string_to_cstring(interpreter, S));
		
		    dval = 1.0e6;
	        S = Parrot_sprintf_c(interpreter, "== %g\n", dval);
	        printf("%g %s", dval, string_to_cstring(interpreter, S));
		
		    fltval = 0.5;
	        S = Parrot_sprintf_c(interpreter, "== %3.3g\n", fltval);
	        printf("%3.3g %s", (double) fltval, 
            string_to_cstring(interpreter, S));
		
                ival = 32;
	        S = Parrot_sprintf_c(interpreter, "== %#x\n", ival);
	        printf("0x%x %s", (int) ival,
            string_to_cstring(interpreter, S));
		
		    /* Test we've not left junk behind on the stack */
	        S = Parrot_sprintf_c(interpreter, "That's all, %s\n", "folks!");
	        printf(string_to_cstring(interpreter, S));
	        return 0;
       }
CODE
Hello, Parrot!
PerlHash[0x100]
PerlHash[0x100]
Hello, Pa!
Hello, Hello, Pa!
1 == 1
-255 == -255
256 == 256
0.500000 == 0.500000
0.500 == 0.500
0.001 == 0.001
1e+06 == 1e+06
0.5 == 0.5
0x20 == 0x20
That's all, folks!
OUTPUT
}
