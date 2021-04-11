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
extern void execute_99(char*, char *);
extern void execute_75(char*, char *);
extern void execute_76(char*, char *);
extern void execute_81(char*, char *);
extern void execute_63(char*, char *);
extern void execute_65(char*, char *);
extern void execute_69(char*, char *);
extern void execute_72(char*, char *);
extern void execute_73(char*, char *);
extern void execute_83(char*, char *);
extern void execute_85(char*, char *);
extern void execute_87(char*, char *);
extern void execute_89(char*, char *);
extern void execute_91(char*, char *);
extern void execute_93(char*, char *);
extern void execute_95(char*, char *);
extern void execute_97(char*, char *);
extern void execute_59(char*, char *);
extern void execute_37(char*, char *);
extern void execute_38(char*, char *);
extern void execute_78(char*, char *);
extern void execute_80(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_6(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_13(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[28] = {(funcp)execute_26, (funcp)execute_27, (funcp)execute_99, (funcp)execute_75, (funcp)execute_76, (funcp)execute_81, (funcp)execute_63, (funcp)execute_65, (funcp)execute_69, (funcp)execute_72, (funcp)execute_73, (funcp)execute_83, (funcp)execute_85, (funcp)execute_87, (funcp)execute_89, (funcp)execute_91, (funcp)execute_93, (funcp)execute_95, (funcp)execute_97, (funcp)execute_59, (funcp)execute_37, (funcp)execute_38, (funcp)execute_78, (funcp)execute_80, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_6, (funcp)transaction_13};
const int NumRelocateId= 28;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/parameterizable_multiplier_tb_behav/xsim.reloc",  (void **)funcTab, 28);
	iki_vhdl_file_variable_register(dp + 7816);
	iki_vhdl_file_variable_register(dp + 7872);


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
