/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_26(char*, char *);
extern void execute_27(char*, char *);
extern void execute_238(char*, char *);
extern void execute_197(char*, char *);
extern void execute_198(char*, char *);
extern void execute_199(char*, char *);
extern void execute_214(char*, char *);
extern void execute_215(char*, char *);
extern void execute_220(char*, char *);
extern void execute_201(char*, char *);
extern void execute_203(char*, char *);
extern void execute_206(char*, char *);
extern void execute_208(char*, char *);
extern void execute_210(char*, char *);
extern void execute_212(char*, char *);
extern void execute_222(char*, char *);
extern void execute_224(char*, char *);
extern void execute_226(char*, char *);
extern void execute_228(char*, char *);
extern void execute_230(char*, char *);
extern void execute_232(char*, char *);
extern void execute_234(char*, char *);
extern void execute_236(char*, char *);
extern void execute_83(char*, char *);
extern void execute_35(char*, char *);
extern void execute_36(char*, char *);
extern void execute_217(char*, char *);
extern void execute_219(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_6(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_7(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_8(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_13(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[34] = {(funcp)execute_26, (funcp)execute_27, (funcp)execute_238, (funcp)execute_197, (funcp)execute_198, (funcp)execute_199, (funcp)execute_214, (funcp)execute_215, (funcp)execute_220, (funcp)execute_201, (funcp)execute_203, (funcp)execute_206, (funcp)execute_208, (funcp)execute_210, (funcp)execute_212, (funcp)execute_222, (funcp)execute_224, (funcp)execute_226, (funcp)execute_228, (funcp)execute_230, (funcp)execute_232, (funcp)execute_234, (funcp)execute_236, (funcp)execute_83, (funcp)execute_35, (funcp)execute_36, (funcp)execute_217, (funcp)execute_219, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_6, (funcp)transaction_7, (funcp)transaction_8, (funcp)transaction_13};
const int NumRelocateId= 34;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/parameterizable_multiplier_tb_behav/xsim.reloc",  (void **)funcTab, 34);
	iki_vhdl_file_variable_register(dp + 18888);
	iki_vhdl_file_variable_register(dp + 18944);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/parameterizable_multiplier_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
	iki_schedule_processes_at_time_zero(dp, "xsim.dir/parameterizable_multiplier_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/parameterizable_multiplier_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/parameterizable_multiplier_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/parameterizable_multiplier_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
