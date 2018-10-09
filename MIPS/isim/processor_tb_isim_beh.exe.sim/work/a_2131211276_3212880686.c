/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xc4ca3437 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/MIPS/Banco_de_Registros.vhd";
extern char *IEEE_P_3620187407;
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1258338084_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_3620187407_sub_4042748798_3965413181(char *, char *, char *, char *, char *);
int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);


static void work_a_2131211276_3212880686_p_0(char *t0)
{
    char t5[16];
    char *t1;
    char *t2;
    char *t3;
    char *t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    int t13;
    int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    xsi_set_current_line(51, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6908U);
    t3 = (t0 + 8118);
    t6 = (t5 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 0;
    t7 = (t6 + 4U);
    *((int *)t7) = 4;
    t7 = (t6 + 8U);
    *((int *)t7) = 1;
    t8 = (4 - 0);
    t9 = (t8 * 1);
    t9 = (t9 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t9;
    t10 = ieee_p_3620187407_sub_4042748798_3965413181(IEEE_P_3620187407, t2, t1, t3, t5);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t23 = (t0 + 8123);
    t25 = (t0 + 4560);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t23, 32U);
    xsi_driver_first_trans_fast_port(t25);

LAB2:    t30 = (t0 + 4448);
    *((int *)t30) = 1;

LAB1:    return;
LAB3:    t7 = (t0 + 2472U);
    t11 = *((char **)t7);
    t7 = (t0 + 1032U);
    t12 = *((char **)t7);
    t7 = (t0 + 6908U);
    t13 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t12, t7);
    t14 = (t13 - 0);
    t9 = (t14 * 1);
    xsi_vhdl_check_range_of_index(0, 31, 1, t13);
    t15 = (32U * t9);
    t16 = (0 + t15);
    t17 = (t11 + t16);
    t18 = (t0 + 4560);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t17, 32U);
    xsi_driver_first_trans_fast_port(t18);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_2131211276_3212880686_p_1(char *t0)
{
    char t5[16];
    char *t1;
    char *t2;
    char *t3;
    char *t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    int t13;
    int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t1 = (t0 + 6924U);
    t3 = (t0 + 8155);
    t6 = (t5 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 0;
    t7 = (t6 + 4U);
    *((int *)t7) = 4;
    t7 = (t6 + 8U);
    *((int *)t7) = 1;
    t8 = (4 - 0);
    t9 = (t8 * 1);
    t9 = (t9 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t9;
    t10 = ieee_p_3620187407_sub_4042748798_3965413181(IEEE_P_3620187407, t2, t1, t3, t5);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t23 = (t0 + 8160);
    t25 = (t0 + 4624);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t23, 32U);
    xsi_driver_first_trans_fast_port(t25);

LAB2:    t30 = (t0 + 4464);
    *((int *)t30) = 1;

LAB1:    return;
LAB3:    t7 = (t0 + 2472U);
    t11 = *((char **)t7);
    t7 = (t0 + 1192U);
    t12 = *((char **)t7);
    t7 = (t0 + 6924U);
    t13 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t12, t7);
    t14 = (t13 - 0);
    t9 = (t14 * 1);
    xsi_vhdl_check_range_of_index(0, 31, 1, t13);
    t15 = (32U * t9);
    t16 = (0 + t15);
    t17 = (t11 + t16);
    t18 = (t0 + 4624);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t17, 32U);
    xsi_driver_first_trans_fast_port(t18);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_2131211276_3212880686_p_2(char *t0)
{
    char t24[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    int t6;
    int t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned char t21;
    unsigned char t22;
    unsigned char t23;
    unsigned char t25;
    unsigned char t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1952U);
    t21 = ieee_p_2592010699_sub_1258338084_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t21 == 1)
        goto LAB15;

LAB16:    t4 = (unsigned char)0;

LAB17:    if (t4 == 1)
        goto LAB12;

LAB13:    t3 = (unsigned char)0;

LAB14:    if (t3 != 0)
        goto LAB10;

LAB11:
LAB3:    t1 = (t0 + 4480);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 8192);
    *((int *)t1) = 0;
    t5 = (t0 + 8196);
    *((int *)t5) = 31;
    t6 = 0;
    t7 = 31;

LAB5:    if (t6 <= t7)
        goto LAB6;

LAB8:    goto LAB3;

LAB6:    xsi_set_current_line(61, ng0);
    t8 = (t0 + 8200);
    t10 = (t0 + 8192);
    t11 = *((int *)t10);
    t12 = (t11 - 0);
    t13 = (t12 * 1);
    t14 = (32U * t13);
    t15 = (0U + t14);
    t16 = (t0 + 4688);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t8, 32U);
    xsi_driver_first_trans_delta(t16, t15, 32U, 0LL);

LAB7:    t1 = (t0 + 8192);
    t6 = *((int *)t1);
    t2 = (t0 + 8196);
    t7 = *((int *)t2);
    if (t6 == t7)
        goto LAB8;

LAB9:    t11 = (t6 + 1);
    t6 = t11;
    t5 = (t0 + 8192);
    *((int *)t5) = t6;
    goto LAB5;

LAB10:    xsi_set_current_line(64, ng0);
    t17 = (t0 + 1512U);
    t18 = *((char **)t17);
    t17 = (t0 + 1352U);
    t19 = *((char **)t17);
    t17 = (t0 + 6940U);
    t7 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t19, t17);
    t11 = (t7 - 0);
    t13 = (t11 * 1);
    t14 = (32U * t13);
    t15 = (0U + t14);
    t20 = (t0 + 4688);
    t27 = (t20 + 56U);
    t28 = *((char **)t27);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    memcpy(t30, t18, 32U);
    xsi_driver_first_trans_delta(t20, t15, 32U, 0LL);
    goto LAB3;

LAB12:    t2 = (t0 + 1352U);
    t8 = *((char **)t2);
    t2 = (t0 + 6940U);
    t9 = (t0 + 8232);
    t16 = (t24 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = 0;
    t17 = (t16 + 4U);
    *((int *)t17) = 4;
    t17 = (t16 + 8U);
    *((int *)t17) = 1;
    t6 = (4 - 0);
    t13 = (t6 * 1);
    t13 = (t13 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t13;
    t25 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t8, t2, t9, t24);
    t26 = (!(t25));
    t3 = t26;
    goto LAB14;

LAB15:    t2 = (t0 + 1672U);
    t5 = *((char **)t2);
    t22 = *((unsigned char *)t5);
    t23 = (t22 == (unsigned char)3);
    t4 = t23;
    goto LAB17;

}


extern void work_a_2131211276_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2131211276_3212880686_p_0,(void *)work_a_2131211276_3212880686_p_1,(void *)work_a_2131211276_3212880686_p_2};
	xsi_register_didat("work_a_2131211276_3212880686", "isim/processor_tb_isim_beh.exe.sim/work/a_2131211276_3212880686.didat");
	xsi_register_executes(pe);
}
