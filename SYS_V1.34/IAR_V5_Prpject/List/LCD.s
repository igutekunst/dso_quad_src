///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:14 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\SYS_V1.34\source\LCD.c                        /
//    Command line =  E:\DS0203\SYS_V1.34\source\LCD.c -lA                    /
//                    E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\SYS_V1.34\IAR_V5_Prpject\Obj\ --no_inline     /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\LCD.s           /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME LCD

        EXTERN Delay_Cnt
        EXTERN __LCD_DMA_Ready
        EXTERN __LCD_Fill
        EXTERN __LCD_SetPixl

        PUBLIC Char_TAB_8x14
        PUBLIC Clear_Screen
        PUBLIC Delayms
        PUBLIC Display_Logo
        PUBLIC Display_Str
        PUBLIC Fill_Buffer
        PUBLIC Get_Pixl
        PUBLIC Get_TAB_8x14
        PUBLIC LCD_EnterSleep_ILI9327
        PUBLIC LCD_ExitSleep_ILI9327
        PUBLIC LCD_Initial
        PUBLIC LCD_RD_Type
        PUBLIC LCD_Set_Block
        PUBLIC LCD_Type
        PUBLIC LCD_WR_Ctrl
        PUBLIC LCD_WR_REG
        PUBLIC Point_SCR
        
        CFI Names cfiNames0
        CFI StackFrame CFA R13 DATA
        CFI Resource R0:32, R1:32, R2:32, R3:32, R4:32, R5:32, R6:32, R7:32
        CFI Resource R8:32, R9:32, R10:32, R11:32, R12:32, R13:32, R14:32
        CFI EndNames cfiNames0
        
        CFI Common cfiCommon0 Using cfiNames0
        CFI CodeAlign 2
        CFI DataAlign 4
        CFI ReturnAddress R14 CODE
        CFI CFA R13+0
        CFI R0 Undefined
        CFI R1 Undefined
        CFI R2 Undefined
        CFI R3 Undefined
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R10 SameValue
        CFI R11 SameValue
        CFI R12 Undefined
        CFI R14 SameValue
        CFI EndCommon cfiCommon0
        
// E:\DS0203\SYS_V1.34\source\LCD.c
//    1 /********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
//    2  File Name : LCD.c  
//    3  Version   : DS203_SYS Ver 1.3x                                  Author : bure
//    4 *******************************************************************************/
//    5 #include "stm32f10x_lib.h"
//    6 #include "Config.h"
//    7 #include "BIOS.h"
//    8 #include "LCD.h"
//    9 #include "ASM.h"
//   10 

        SECTION `.bss`:DATA:NOROOT(2)
//   11 u32 LCD_Type;
LCD_Type:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(1)
//   12 u16 Fill_Buffer;
Fill_Buffer:
        DS8 2
//   13 //================================ �ֿⶨ�� ====================================

        SECTION `.rodata`:CONST:NOROOT(2)
//   14 uc16 Char_TAB_8x14[744] =
Char_TAB_8x14:
        DATA
        DC16 0, 0, 0, 28, 32, 64, 64, 64, 64, 64, 32, 28, 0, 0, 0, 0, 0, 0, 0
        DC16 57344, 4096, 2048, 2048, 2048, 3120, 3168, 192, 384, 768, 1584
        DC16 3120, 0, 2048, 2048, 4096, 57344, 0, 0, 0, 0, 8208, 8208, 8208
        DC16 8208, 8208, 8208, 16368, 0, 0, 0, 4032, 8160, 12336, 8208, 0, 0, 0
        DC16 0, 8208, 12336, 8160, 4032, 0, 0, 0, 6336, 3456, 1792, 1792, 3456
        DC16 6336, 0, 0, 256, 256, 1984, 1984, 256, 256, 0, 0, 0, 0, 65532, 0
        DC16 0, 0, 0, 0, 256, 256, 256, 256, 256, 256, 0, 0, 0, 0, 48, 48, 0, 0
        DC16 0, 48, 96, 192, 384, 768, 1536, 3072, 0, 8160, 16368, 8336, 8976
        DC16 9232, 16368, 8160, 0, 0, 2064, 6160, 16368, 16368, 16, 16, 0, 4208
        DC16 12528, 8592, 8976, 9744, 14384, 6192, 0, 4128, 12336, 8720, 8720
        DC16 8720, 16368, 7648, 0, 768, 1792, 3328, 6416, 16368, 16368, 272, 0
        DC16 15904, 15920, 8720, 8720, 8976, 9200, 8672, 0, 4064, 8176, 12816
        DC16 8720, 8720, 1008, 480, 0, 12288, 12288, 8432, 8688, 8960, 15872
        DC16 15360, 0, 7648, 16368, 8720, 8720, 8720, 16368, 7648, 0, 7168
        DC16 15888, 8720, 8720, 8752, 16352, 8128, 0, 0, 0, 0, 3168, 3168, 0, 0
        DC16 0, 64, 64, 64, 64, 64, 64, 64, 64, 0, 256, 896, 1728, 3168, 6192
        DC16 4112, 0, 0, 144, 144, 144, 144, 144, 144, 0, 576, 576, 576, 576
        DC16 576, 576, 576, 0, 0, 4112, 6192, 3168, 1728, 896, 256, 0, 4032
        DC16 4128, 10128, 9360, 10192, 4176, 3968, 0, 2032, 4080, 6400, 12544
        DC16 6400, 4080, 2032, 0, 8208, 16368, 16368, 8720, 8720, 16368, 7648
        DC16 0, 4032, 8160, 12336, 8208, 8208, 12336, 6240, 0, 8208, 16368
        DC16 16368, 8208, 12336, 8160, 4032, 0, 8208, 16368, 16368, 8720, 10000
        DC16 12336, 14448, 0, 8208, 16368, 16368, 8720, 9984, 12288, 14336, 0
        DC16 4032, 8160, 12336, 8464, 8464, 12768, 6640, 0, 16368, 16368, 512
        DC16 512, 512, 16368, 16368, 0, 0, 0, 8208, 16368, 16368, 8208, 0, 0
        DC16 224, 240, 16, 8208, 16368, 16352, 8192, 0, 8208, 16368, 16368, 768
        DC16 3840, 15600, 12400, 0, 8208, 16368, 16368, 8208, 16, 48, 48, 0
        DC16 16368, 16368, 7168, 3584, 7168, 16368, 16368, 0, 16368, 16368
        DC16 7168, 3584, 1792, 16368, 16368, 0, 4032, 8160, 12336, 8208, 12336
        DC16 8160, 4032, 0, 8208, 16368, 16368, 8720, 8704, 15872, 7168, 0
        DC16 8160, 16368, 8208, 8304, 8240, 16376, 8168, 0, 8208, 16368, 16368
        DC16 8704, 8960, 16368, 7408, 0, 6240, 15472, 9744, 8720, 8976, 14832
        DC16 6368, 0, 0, 14336, 12304, 16368, 16368, 12304, 14336, 0, 16352
        DC16 16368, 16, 16, 16, 16368, 16352, 0, 16256, 16320, 96, 48, 96
        DC16 16320, 16256, 0, 16320, 16368, 112, 448, 112, 16368, 16320, 0
        DC16 12336, 15600, 4032, 768, 4032, 15600, 12336, 0, 0, 15360, 15888
        DC16 1008, 1008, 15888, 15360, 0, 14448, 12528, 8592, 8976, 9744, 15408
        DC16 14448, 0, 16, 48, 80, 400, 784, 3088, 16368, 0, 2048, 2048, 2048
        DC16 2048, 2048, 2048, 2048, 2048, 0, 0, 0, 64636, 640, 640, 256, 256
        DC16 512, 1024, 3072, 8176, 16368, 3072, 1024, 512, 256, 128, 192
        DC16 16352, 16368, 192, 128, 256, 8208, 8208, 8208, 8208, 8208, 8208
        DC16 8208, 8208, 224, 1520, 1296, 1296, 2016, 1008, 16, 0, 8208, 16368
        DC16 16352, 528, 528, 1008, 480, 0, 992, 2032, 1040, 1040, 1040, 1584
        DC16 544, 0, 480, 1008, 1552, 9232, 16368, 16368, 16, 0, 992, 2032
        DC16 1296, 1296, 1296, 1840, 800, 0, 0, 528, 8176, 16368, 8720, 12288
        DC16 6144, 0, 968, 2028, 1060, 1060, 1020, 2040, 1024, 0, 8208, 16368
        DC16 16368, 544, 1024, 2032, 1008, 0, 0, 0, 1040, 14320, 14320, 16, 0
        DC16 0, 0, 24, 28, 1028, 14332, 14328, 1024, 0, 8208, 16368, 16368
        DC16 8576, 960, 1648, 1072, 0, 0, 0, 8208, 16368, 16368, 16, 0, 0, 2032
        DC16 2032, 1536, 1008, 1536, 2032, 2032, 0, 1024, 2032, 1008, 1024
        DC16 1024, 2032, 1008, 0, 992, 2032, 1040, 1040, 1040, 2032, 992, 0
        DC16 1028, 2044, 1020, 1092, 1088, 1984, 896, 0, 896, 1984, 1088, 1092
        DC16 2044, 1020, 1028, 0, 1040, 2032, 1008, 1552, 1024, 1536, 768, 0, 0
        DC16 544, 1840, 1424, 1168, 1776, 608, 0, 1024, 1024, 8160, 16368, 1040
        DC16 1072, 32, 0, 2016, 2032, 16, 16, 2016, 2032, 16, 0, 0, 1984, 2016
        DC16 48, 48, 2016, 1984, 0, 2016, 2032, 48, 224, 48, 2032, 2016, 0
        DC16 1040, 1584, 992, 448, 992, 1584, 1040, 0, 1920, 1988, 68, 68, 68
        DC16 2040, 2032, 0, 1584, 1648, 1232, 1424, 1808, 1584, 1072, 0, 1920
        DC16 1152, 15600, 8208, 12240, 12240, 12240, 12240, 12240, 12240, 12240
        DC16 12240, 12240, 12240, 12240, 12240, 12240, 12240, 12240, 12240
        DC16 12240, 8208, 16368, 0, 1920, 1152, 15600, 8208, 8208, 8208, 8208
        DC16 8208
//   15 {
//   16    0x0000,0x0000,0x0000,0x001C,0x0020,0x0040,0x0040,0x0040, // " ���Ͻ�
//   17    0x0040,0x0040,0x0020,0x001C,0x0000,0x0000,0x0000,0x0000, // # ���Ͻ�
//   18    0x0000,0x0000,0x0000,0xE000,0x1000,0x0800,0x0800,0x0800, // $ ���½�
//   19    0x0C30,0x0C60,0x00C0,0x0180,0x0300,0x0630,0x0C30,0x0000, // %    
//   20    0x0800,0x0800,0x1000,0xE000,0x0000,0x0000,0x0000,0x0000, // & ���½�
//   21    0x2010,0x2010,0x2010,0x2010,0x2010,0x2010,0x3FF0,0x0000, // ' ���β��
//   22    0x0000,0x0000,0x0FC0,0x1FE0,0x3030,0x2010,0x0000,0x0000, // (    
//   23    0x0000,0x0000,0x2010,0x3030,0x1FE0,0x0FC0,0x0000,0x0000, // )    
//   24    0x0000,0x18C0,0x0D80,0x0700,0x0700,0x0D80,0x18C0,0x0000, // *  ��
//   25    0x0000,0x0100,0x0100,0x07C0,0x07C0,0x0100,0x0100,0x0000, // +    
//   26    0x0000,0x0000,0x0000,0xFFFC,0x0000,0x0000,0x0000,0x0000, // , ����
//   27    0x0000,0x0100,0x0100,0x0100,0x0100,0x0100,0x0100,0x0000, // -    
//   28    0x0000,0x0000,0x0000,0x0030,0x0030,0x0000,0x0000,0x0000, // .    
//   29    0x0030,0x0060,0x00C0,0x0180,0x0300,0x0600,0x0C00,0x0000, // /    
//   30    0x1FE0,0x3FF0,0x2090,0x2310,0x2410,0x3FF0,0x1FE0,0x0000, // 0    
//   31    0x0000,0x0810,0x1810,0x3FF0,0x3FF0,0x0010,0x0010,0x0000, // 1    
//   32    0x1070,0x30F0,0x2190,0x2310,0x2610,0x3830,0x1830,0x0000, // 2    
//   33    0x1020,0x3030,0x2210,0x2210,0x2210,0x3FF0,0x1DE0,0x0000, // 3    
//   34    0x0300,0x0700,0x0D00,0x1910,0x3FF0,0x3FF0,0x0110,0x0000, // 4    
//   35    0x3E20,0x3E30,0x2210,0x2210,0x2310,0x23F0,0x21E0,0x0000, // 5    
//   36    0x0FE0,0x1FF0,0x3210,0x2210,0x2210,0x03F0,0x01E0,0x0000, // 6    
//   37    0x3000,0x3000,0x20F0,0x21F0,0x2300,0x3E00,0x3C00,0x0000, // 7    
//   38    0x1DE0,0x3FF0,0x2210,0x2210,0x2210,0x3FF0,0x1DE0,0x0000, // 8    
//   39    0x1C00,0x3E10,0x2210,0x2210,0x2230,0x3FE0,0x1FC0,0x0000, // 9    
//   40    0x0000,0x0000,0x0000,0x0C60,0x0C60,0x0000,0x0000,0x0000, // :    
//   41    0x0040,0x0040,0x0040,0x0040,0x0040,0x0040,0x0040,0x0040, // ; �Ϻ���
//   42    0x0000,0x0100,0x0380,0x06C0,0x0C60,0x1830,0x1010,0x0000, // <    
//   43    0x0000,0x0090,0x0090,0x0090,0x0090,0x0090,0x0090,0x0000, // =    
//   44    0x0240,0x0240,0x0240,0x0240,0x0240,0x0240,0x0240,0x0000, // >    
//   45    0x0000,0x1010,0x1830,0x0C60,0x06C0,0x0380,0x0100,0x0000, // ?    
//   46    0x0FC0,0x1020,0x2790,0x2490,0x27D0,0x1050,0x0F80,0x0000, // @    
//   47    0x07F0,0x0FF0,0x1900,0x3100,0x1900,0x0FF0,0x07F0,0x0000, // A    
//   48    0x2010,0x3FF0,0x3FF0,0x2210,0x2210,0x3FF0,0x1DE0,0x0000, // B    
//   49    0x0FC0,0x1FE0,0x3030,0x2010,0x2010,0x3030,0x1860,0x0000, // C    
//   50    0x2010,0x3FF0,0x3FF0,0x2010,0x3030,0x1FE0,0x0FC0,0x0000, // D    
//   51    0x2010,0x3FF0,0x3FF0,0x2210,0x2710,0x3030,0x3870,0x0000, // E    
//   52    0x2010,0x3FF0,0x3FF0,0x2210,0x2700,0x3000,0x3800,0x0000, // F    
//   53    0x0FC0,0x1FE0,0x3030,0x2110,0x2110,0x31E0,0x19F0,0x0000, // G    
//   54    0x3FF0,0x3FF0,0x0200,0x0200,0x0200,0x3FF0,0x3FF0,0x0000, // H    
//   55    0x0000,0x0000,0x2010,0x3FF0,0x3FF0,0x2010,0x0000,0x0000, // I    
//   56    0x00E0,0x00F0,0x0010,0x2010,0x3FF0,0x3FE0,0x2000,0x0000, // J    
//   57    0x2010,0x3FF0,0x3FF0,0x0300,0x0F00,0x3CF0,0x3070,0x0000, // K    
//   58    0x2010,0x3FF0,0x3FF0,0x2010,0x0010,0x0030,0x0030,0x0000, // L    
//   59    0x3FF0,0x3FF0,0x1C00,0x0E00,0x1C00,0x3FF0,0x3FF0,0x0000, // M    
//   60    0x3FF0,0x3FF0,0x1C00,0x0E00,0x0700,0x3FF0,0x3FF0,0x0000, // N    
//   61    0x0FC0,0x1FE0,0x3030,0x2010,0x3030,0x1FE0,0x0FC0,0x0000, // O    
//   62    0x2010,0x3FF0,0x3FF0,0x2210,0x2200,0x3E00,0x1C00,0x0000, // P    
//   63    0x1FE0,0x3FF0,0x2010,0x2070,0x2030,0x3FF8,0x1FE8,0x0000, // Q    
//   64    0x2010,0x3FF0,0x3FF0,0x2200,0x2300,0x3FF0,0x1CF0,0x0000, // R    
//   65    0x1860,0x3C70,0x2610,0x2210,0x2310,0x39F0,0x18E0,0x0000, // S    
//   66    0x0000,0x3800,0x3010,0x3FF0,0x3FF0,0x3010,0x3800,0x0000, // T    
//   67    0x3FE0,0x3FF0,0x0010,0x0010,0x0010,0x3FF0,0x3FE0,0x0000, // U    
//   68    0x3F80,0x3FC0,0x0060,0x0030,0x0060,0x3FC0,0x3F80,0x0000, // V    
//   69    0x3FC0,0x3FF0,0x0070,0x01C0,0x0070,0x3FF0,0x3FC0,0x0000, // W    
//   70    0x3030,0x3CF0,0x0FC0,0x0300,0x0FC0,0x3CF0,0x3030,0x0000, // X    
//   71    0x0000,0x3C00,0x3E10,0x03F0,0x03F0,0x3E10,0x3C00,0x0000, // Y    
//   72    0x3870,0x30F0,0x2190,0x2310,0x2610,0x3C30,0x3870,0x0000, // Z    
//   73    0x0010,0x0030,0x0050,0x0190,0x0310,0x0C10,0x3FF0,0x0000, // [ ����
//   74    0x0800,0x0800,0x0800,0x0800,0x0800,0x0800,0x0800,0x0800, // \ �º���
//   75    0x0000,0x0000,0x0000,0xFC7C,0x0280,0x0280,0x0100,0x0100, // ] ָ��
//   76    0x0200,0x0400,0x0C00,0x1FF0,0x3FF0,0x0C00,0x0400,0x0200, // ^ ������
//   77    0x0100,0x0080,0x00C0,0x3FE0,0x3FF0,0x00C0,0x0080,0x0100, // _ �½���
//   78    0x2010,0x2010,0x2010,0x2010,0x2010,0x2010,0x2010,0x2010, // ` ������
//   79    0x00E0,0x05F0,0x0510,0x0510,0x07E0,0x03F0,0x0010,0x0000, // a    
//   80    0x2010,0x3FF0,0x3FE0,0x0210,0x0210,0x03F0,0x01E0,0x0000, // b    
//   81    0x03E0,0x07F0,0x0410,0x0410,0x0410,0x0630,0x0220,0x0000, // c    
//   82    0x01E0,0x03F0,0x0610,0x2410,0x3FF0,0x3FF0,0x0010,0x0000, // d    
//   83    0x03E0,0x07F0,0x0510,0x0510,0x0510,0x0730,0x0320,0x0000, // e    
//   84    0x0000,0x0210,0x1FF0,0x3FF0,0x2210,0x3000,0x1800,0x0000, // f    
//   85    0x03C8,0x07EC,0x0424,0x0424,0x03FC,0x07F8,0x0400,0x0000, // g    
//   86    0x2010,0x3FF0,0x3FF0,0x0220,0x0400,0x07F0,0x03F0,0x0000, // h    
//   87    0x0000,0x0000,0x0410,0x37F0,0x37F0,0x0010,0x0000,0x0000, // i    
//   88    0x0000,0x0018,0x001C,0x0404,0x37FC,0x37F8,0x0400,0x0000, // j    
//   89    0x2010,0x3FF0,0x3FF0,0x2180,0x03C0,0x0670,0x0430,0x0000, // k    
//   90    0x0000,0x0000,0x2010,0x3FF0,0x3FF0,0x0010,0x0000,0x0000, // l    
//   91    0x07F0,0x07F0,0x0600,0x03F0,0x0600,0x07F0,0x07F0,0x0000, // m    
//   92    0x0400,0x07F0,0x03F0,0x0400,0x0400,0x07F0,0x03F0,0x0000, // n    
//   93    0x03E0,0x07F0,0x0410,0x0410,0x0410,0x07F0,0x03E0,0x0000, // o    
//   94    0x0404,0x07FC,0x03FC,0x0444,0x0440,0x07C0,0x0380,0x0000, // p    
//   95    0x0380,0x07C0,0x0440,0x0444,0x07FC,0x03FC,0x0404,0x0000, // q    
//   96    0x0410,0x07F0,0x03F0,0x0610,0x0400,0x0600,0x0300,0x0000, // r    
//   97    0x0000,0x0220,0x0730,0x0590,0x0490,0x06F0,0x0260,0x0000, // s    
//   98    0x0400,0x0400,0x1FE0,0x3FF0,0x0410,0x0430,0x0020,0x0000, // t    
//   99    0x07E0,0x07F0,0x0010,0x0010,0x07E0,0x07F0,0x0010,0x0000, // u    
//  100    0x0000,0x07C0,0x07E0,0x0030,0x0030,0x07E0,0x07C0,0x0000, // v    
//  101    0x07E0,0x07F0,0x0030,0x00E0,0x0030,0x07F0,0x07E0,0x0000, // w    
//  102    0x0410,0x0630,0x03E0,0x01C0,0x03E0,0x0630,0x0410,0x0000, // x    
//  103    0x0780,0x07C4,0x0044,0x0044,0x0044,0x07F8,0x07F0,0x0000, // y    
//  104    0x0630,0x0670,0x04D0,0x0590,0x0710,0x0630,0x0430,0x0000, // z    
//  105    0x0780,0x0480,0x3CF0,0x2010,0x2FD0,0x2FD0,0x2FD0,0x2FD0, // { ���ͷ
//  106    0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0, // | �����
//  107    0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2010,0x3FF0,0x0000, // } ���β
//  108    0x0780,0x0480,0x3CF0,0x2010,0x2010,0x2010,0x2010,0x2010 // ~ �յ��ͷ
//  109 };
//  110 
//  111 /*******************************************************************************
//  112  LCD_Initial: 400x240 LCD��ʾģ���ʼ���� 
//  113 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function LCD_Initial
        THUMB
//  114 void LCD_Initial(void)
//  115 {   
LCD_Initial:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  116   //------------------------- Reset LCD Driver ---------------------//
//  117   LCD_RS_HIGH();
        LDR.W    R4,??DataTable17  ;; 0x40011410
        MOV      R0,#+4096
        STR      R0,[R4, #+0]
//  118   LCD_nRST_HIGH(); 
        MOV      R0,#+2048
        STR      R0,[R4, #+0]
//  119   Delayms(1);           //RST=1��Delay 1ms      
        MOVS     R0,#+1
        BL       Delayms
//  120   LCD_nRST_LOW(); 
        MOV      R1,#+2048
        STR      R1,[R4, #+4]
//  121   Delayms(10);          //RST=0 Reset LCD��Delay 1ms      
        MOVS     R0,#+10
        BL       Delayms
//  122   LCD_nRST_HIGH(); 
        MOV      R0,#+2048
        STR      R0,[R4, #+0]
//  123   Delayms(50);          //RST=1��Delay 5 ms  
        MOVS     R0,#+50
        BL       Delayms
//  124   LCD_RD_Type();
        BL       LCD_RD_Type
//  125   if(LCD_Type == 0x02049327){
        MOV      R5,#+1610612736
        LDR.W    R0,??DataTable14  ;; LCD_Type
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable15  ;; 0x2049327
        CMP      R0,R1
        BNE.N    ??LCD_Initial_0
//  126  //----------- ILI9327_HSD3.0 Internal Register Initial -----------//         
//  127     LCD_WR_Ctrl(0xE9); 
        MOVS     R0,#+233
        BL       LCD_WR_Ctrl
//  128     LCD_PORT =  0x20; 
        MOVS     R0,#+32
        STRH     R0,[R5, #+0]
//  129     LCD_WR_Ctrl(0x11);   //Exit Sleep  
        MOVS     R0,#+17
        BL       LCD_WR_Ctrl
//  130     Delayms(100);           
        MOVS     R0,#+100
        BL       Delayms
//  131     LCD_WR_Ctrl(0xD1); 
        MOVS     R0,#+209
        BL       LCD_WR_Ctrl
//  132     LCD_PORT =  0x00; 
        MOVS     R0,#+0
        STRH     R0,[R5, #+0]
//  133     LCD_PORT =  0x5E; 
        MOVS     R0,#+94
        STRH     R0,[R5, #+0]
//  134     LCD_PORT =  0x17; //1F 
        MOVS     R0,#+23
        STRH     R0,[R5, #+0]
//  135 
//  136     LCD_WR_Ctrl(0xD0); 
        MOVS     R0,#+208
        BL       LCD_WR_Ctrl
//  137     LCD_PORT =  0x07; 
        MOVS     R0,#+7
        STRH     R0,[R5, #+0]
//  138     LCD_PORT =  0x07; 
        STRH     R0,[R5, #+0]
//  139     LCD_PORT =  0x0C; //80 
        MOVS     R0,#+12
        STRH     R0,[R5, #+0]
//  140   
//  141     LCD_WR_Ctrl(0x36); 
        MOVS     R0,#+54
        BL       LCD_WR_Ctrl
//  142     LCD_PORT =  0x40; // 48
        MOVS     R0,#+64
        STRH     R0,[R5, #+0]
//  143   
//  144     LCD_WR_Ctrl(0x0C); 
        MOVS     R0,#+12
        BL       LCD_WR_Ctrl
//  145     LCD_PORT =  0x55; 
        MOVS     R0,#+85
        STRH     R0,[R5, #+0]
//  146   
//  147     LCD_WR_Ctrl(0x3A); 
        MOVS     R0,#+58
        BL       LCD_WR_Ctrl
//  148     LCD_PORT =  0x55; 
        MOVS     R0,#+85
        STRH     R0,[R5, #+0]
//  149   
//  150     LCD_WR_Ctrl(0xC1); 
        MOVS     R0,#+193
        BL       LCD_WR_Ctrl
//  151     LCD_PORT =  0x10; 
        MOVS     R0,#+16
        STRH     R0,[R5, #+0]
//  152     LCD_PORT =  0x10; 
        STRH     R0,[R5, #+0]
//  153     LCD_PORT =  0x02; 
        MOVS     R0,#+2
        STRH     R0,[R5, #+0]
//  154     LCD_PORT =  0x02; 
        STRH     R0,[R5, #+0]
//  155   
//  156     LCD_WR_Ctrl(0xC0);   //Set Default Gamma 
        MOVS     R0,#+192
        BL       LCD_WR_Ctrl
//  157     LCD_PORT =  0x00; 
        MOVS     R0,#+0
        STRH     R0,[R5, #+0]
//  158     LCD_PORT =  0x35; 
        MOVS     R0,#+53
        STRH     R0,[R5, #+0]
//  159     LCD_PORT =  0x00; 
        MOVS     R0,#+0
        STRH     R0,[R5, #+0]
//  160     LCD_PORT =  0x00; 
        STRH     R0,[R5, #+0]
//  161     LCD_PORT =  0x01; 
        MOVS     R0,#+1
        STRH     R0,[R5, #+0]
//  162     LCD_PORT =  0x02; 
        MOVS     R0,#+2
        STRH     R0,[R5, #+0]
//  163   
//  164     LCD_WR_Ctrl(0xC5);   //Set frame rate  
        MOVS     R0,#+197
        BL       LCD_WR_Ctrl
//  165     LCD_PORT =  0x01; 
        MOVS     R0,#+1
        STRH     R0,[R5, #+0]
//  166 
//  167     LCD_WR_Ctrl(0xD2);   //power setting
        MOVS     R0,#+210
        BL       LCD_WR_Ctrl
//  168     LCD_PORT =  0x01; 
        MOVS     R0,#+1
        STRH     R0,[R5, #+0]
//  169     LCD_PORT =  0x22; 
        MOVS     R0,#+34
        STRH     R0,[R5, #+0]
//  170 
//  171     LCD_WR_Ctrl(0xC8);   //Set Gamma 
        MOVS     R0,#+200
        BL       LCD_WR_Ctrl
//  172     LCD_PORT =  0x01; 
        MOVS     R0,#+1
        STRH     R0,[R5, #+0]
//  173     LCD_PORT =  0x73; 
        MOVS     R0,#+115
        STRH     R0,[R5, #+0]
//  174     LCD_PORT =  0x37; 
        MOVS     R0,#+55
        STRH     R0,[R5, #+0]
//  175     LCD_PORT =  0x00; 
        MOVS     R0,#+0
        STRH     R0,[R5, #+0]
//  176     LCD_PORT =  0x0F; 
        MOVS     R0,#+15
        STRH     R0,[R5, #+0]
//  177     LCD_PORT =  0x02; 
        MOVS     R0,#+2
        STRH     R0,[R5, #+0]
//  178     LCD_PORT =  0x04; 
        MOVS     R0,#+4
        STRH     R0,[R5, #+0]
//  179     LCD_PORT =  0x40; 
        MOVS     R0,#+64
        STRH     R0,[R5, #+0]
//  180     LCD_PORT =  0x67; 
        MOVS     R0,#+103
        STRH     R0,[R5, #+0]
//  181     LCD_PORT =  0x00; 
        MOVS     R0,#+0
        STRH     R0,[R5, #+0]
//  182     LCD_PORT =  0x02; 
        MOVS     R0,#+2
        STRH     R0,[R5, #+0]
//  183     LCD_PORT =  0x0F; 
        MOVS     R0,#+15
        STRH     R0,[R5, #+0]
//  184     LCD_PORT =  0x08; 
        MOVS     R0,#+8
        STRH     R0,[R5, #+0]
//  185     LCD_PORT =  0x80; 
        MOVS     R0,#+128
        STRH     R0,[R5, #+0]
//  186     LCD_PORT =  0x00; 
        MOVS     R0,#+0
        STRH     R0,[R5, #+0]
//  187   
//  188     LCD_WR_Ctrl(0x29);   //display on 
        MOVS     R0,#+41
        BL       LCD_WR_Ctrl
//  189     LCD_WR_Ctrl(0x2C); 
        MOVS     R0,#+44
        BL       LCD_WR_Ctrl
        POP      {R4-R6,PC}
//  190   } else {
//  191  //----------------R61509V_CPT30 Internal Register Initial------------//         
//  192     LCD_WR_REG(0x0000, 0x0000); 
??LCD_Initial_0:
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       LCD_WR_REG
//  193     LCD_WR_REG(0x0000, 0x0000); 
        MOVS     R1,#+0
        MOV      R0,R1
        BL       LCD_WR_REG
//  194     LCD_WR_REG(0x0000, 0x0000); 
        MOVS     R1,#+0
        MOV      R0,R1
        BL       LCD_WR_REG
//  195     LCD_WR_REG(0x0000, 0x0000); 
        MOVS     R1,#+0
        MOV      R0,R1
        BL       LCD_WR_REG
//  196     Delayms(10); 
        MOVS     R0,#+10
        BL       Delayms
//  197     LCD_WR_REG(0x0600, 0x0001);
        MOVS     R1,#+1
        MOV      R0,#+1536
        BL       LCD_WR_REG
//  198     Delayms(10);
        MOVS     R0,#+10
        BL       Delayms
//  199     LCD_WR_REG(0x06f0, 0x0040);
        MOVS     R1,#+64
        MOV      R0,#+1776
        BL       LCD_WR_REG
//  200     Delayms(10);
        MOVS     R0,#+10
        BL       Delayms
//  201     LCD_WR_REG(0x0400, 0x6200); 
        MOV      R1,#+25088
        MOV      R0,#+1024
        BL       LCD_WR_REG
//  202     LCD_WR_REG(0x0008, 0x0808); 
        MOVW     R1,#+2056
        MOVS     R0,#+8
        BL       LCD_WR_REG
//  203     LCD_WR_REG(0x0001, 0x0100); 
        MOV      R1,#+256
        MOVS     R0,#+1
        BL       LCD_WR_REG
//  204     LCD_WR_REG(0x0002, 0x0100); 
        MOV      R1,#+256
        MOVS     R0,#+2
        BL       LCD_WR_REG
//  205     LCD_WR_REG(0x0003, 0x0030);   //LCD_WR_REG(0x0003, 0x1030); 
        MOVS     R1,#+48
        MOVS     R0,#+3
        BL       LCD_WR_REG
//  206     LCD_WR_REG(0x0009, 0x0001); 
        MOVS     R1,#+1
        MOVS     R0,#+9
        BL       LCD_WR_REG
//  207     LCD_WR_REG(0x000C, 0x0000);
        MOVS     R1,#+0
        MOVS     R0,#+12
        BL       LCD_WR_REG
//  208     LCD_WR_REG(0x0090, 0x8000);
        MOV      R1,#+32768
        MOVS     R0,#+144
        BL       LCD_WR_REG
//  209     LCD_WR_REG(0x000F, 0x0000);
        MOVS     R1,#+0
        MOVS     R0,#+15
        BL       LCD_WR_REG
//  210     LCD_WR_REG(0x0010, 0x0016);
        MOVS     R1,#+22
        MOVS     R0,#+16
        BL       LCD_WR_REG
//  211     LCD_WR_REG(0x0011, 0x0101);
        MOVW     R6,#+257
        MOVS     R1,R6
        MOVS     R0,#+17
        BL       LCD_WR_REG
//  212     LCD_WR_REG(0x0012, 0x0000);
        MOVS     R1,#+0
        MOVS     R0,#+18
        BL       LCD_WR_REG
//  213     LCD_WR_REG(0x0013, 0x0001);
        MOVS     R1,#+1
        MOVS     R0,#+19
        BL       LCD_WR_REG
//  214     LCD_WR_REG(0x0100, 0x0330);
        MOV      R1,#+816
        MOV      R0,#+256
        BL       LCD_WR_REG
//  215     LCD_WR_REG(0x0101, 0x0237);
        MOVW     R1,#+567
        MOVS     R0,R6
        BL       LCD_WR_REG
//  216     LCD_WR_REG(0x0103, 0x0F00); 
        MOV      R1,#+3840
        MOVW     R0,#+259
        BL       LCD_WR_REG
//  217     LCD_WR_REG(0x0280, 0x6B00); 
        MOV      R1,#+27392
        MOV      R0,#+640
        BL       LCD_WR_REG
//  218     LCD_WR_REG(0x0102, 0xC1B0);
        MOVW     R1,#+49584
        MOV      R0,#+258
        BL       LCD_WR_REG
//  219     Delayms(100); 
        MOVS     R0,#+100
        BL       Delayms
//  220     LCD_WR_REG(0x0300, 0x0C00); 
        MOV      R1,#+3072
        MOV      R0,#+768
        BL       LCD_WR_REG
//  221     LCD_WR_REG(0x0301, 0x5A0B); 
        MOVW     R1,#+23051
        MOVW     R0,#+769
        BL       LCD_WR_REG
//  222     LCD_WR_REG(0x0302, 0x0906); 
        MOVW     R1,#+2310
        MOVW     R0,#+770
        BL       LCD_WR_REG
//  223     LCD_WR_REG(0x0303, 0x1017); 
        MOVW     R1,#+4119
        MOVW     R0,#+771
        BL       LCD_WR_REG
//  224     LCD_WR_REG(0x0304, 0x2300); 
        MOV      R1,#+8960
        MOV      R0,#+772
        BL       LCD_WR_REG
//  225     LCD_WR_REG(0x0305, 0x1700); 
        MOV      R1,#+5888
        MOVW     R0,#+773
        BL       LCD_WR_REG
//  226     LCD_WR_REG(0x0306, 0x6309);
        MOVW     R1,#+25353
        MOVW     R0,#+774
        BL       LCD_WR_REG
//  227     LCD_WR_REG(0x0307, 0x0C09);
        MOVW     R1,#+3081
        MOVW     R0,#+775
        BL       LCD_WR_REG
//  228     LCD_WR_REG(0x0308, 0x100C);
        MOVW     R1,#+4108
        MOV      R0,#+776
        BL       LCD_WR_REG
//  229     LCD_WR_REG(0x0309, 0x2232);
        MOVW     R1,#+8754
        MOVW     R0,#+777
        BL       LCD_WR_REG
//  230   
//  231     LCD_WR_REG(0x0210, 0x0000);
        MOVS     R1,#+0
        MOV      R0,#+528
        BL       LCD_WR_REG
//  232     LCD_WR_REG(0x0211, 0x00EF);
        MOVS     R1,#+239
        MOVW     R0,#+529
        BL       LCD_WR_REG
//  233     LCD_WR_REG(0x0212, 0x0000);
        MOVS     R1,#+0
        MOVW     R0,#+530
        BL       LCD_WR_REG
//  234     LCD_WR_REG(0x0213, 0x018F);
        MOVW     R1,#+399
        MOVW     R0,#+531
        BL       LCD_WR_REG
//  235     LCD_WR_REG(0x0500, 0x0000);
        MOVS     R1,#+0
        MOV      R0,#+1280
        BL       LCD_WR_REG
//  236     LCD_WR_REG(0x0501, 0x0000);
        MOVS     R1,#+0
        MOVW     R0,#+1281
        BL       LCD_WR_REG
//  237     LCD_WR_REG(0x0502, 0x0005);
        MOVS     R1,#+5
        MOVW     R0,#+1282
        BL       LCD_WR_REG
//  238     LCD_WR_REG(0x0401, 0x0001);
        MOVS     R1,#+1
        MOVW     R0,#+1025
        BL       LCD_WR_REG
//  239     LCD_WR_REG(0x0404, 0x0000);
        MOVS     R1,#+0
        MOVW     R0,#+1028
        BL       LCD_WR_REG
//  240     Delayms(100);
        MOVS     R0,#+100
        BL       Delayms
//  241     LCD_WR_REG(0x0007, 0x0100);
        MOV      R1,#+256
        MOVS     R0,#+7
        BL       LCD_WR_REG
//  242     Delayms(100);
        MOVS     R0,#+100
        BL       Delayms
//  243     LCD_WR_REG(0x0200, 0x0000);
        MOVS     R1,#+0
        MOV      R0,#+512
        BL       LCD_WR_REG
//  244     LCD_WR_REG(0x0201, 0x0000); 
        MOVS     R1,#+0
        MOVW     R0,#+513
        BL       LCD_WR_REG
//  245 
//  246     LCD_RS_LOW();
        MOV      R1,#+4096
        STR      R1,[R4, #+4]
//  247     LCD_PORT = 0x0202;     //Reg. Addr.
        MOVW     R0,#+514
        STRH     R0,[R5, #+0]
//  248     LCD_RS_HIGH();
        STR      R1,[R4, #+0]
//  249   }
//  250 }
??LCD_Initial_1:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock0
//  251 /*******************************************************************************
//  252  LCD_WR_REG: ����LCDģ����ָ���Ĵ�����ֵ�� ����: �Ĵ�����ַ���Ĵ���ֵ��
//  253 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function LCD_WR_REG
        THUMB
//  254 void LCD_WR_REG(u16 Reg, u16 Data) 
//  255 {
//  256   LCD_RS_LOW();
LCD_WR_REG:
        LDR.W    R2,??DataTable17  ;; 0x40011410
        MOV      R3,#+4096
        STR      R3,[R2, #+4]
//  257   LCD_PORT = Reg;        //Reg. Addr.
        MOV      R2,#+1610612736
        STRH     R0,[R2, #+0]
//  258   LCD_RS_HIGH();
        LDR.W    R0,??DataTable17  ;; 0x40011410
        STR      R3,[R0, #+0]
//  259   LCD_PORT  = Data;       //Reg. Data 
        STRH     R1,[R2, #+0]
//  260 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  261 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function LCD_EnterSleep_ILI9327
        THUMB
//  262 void LCD_EnterSleep_ILI9327(void) 
//  263 { 
//  264   LCD_WR_Ctrl(0x10); 
LCD_EnterSleep_ILI9327:
        MOVS     R0,#+16
        B.N      LCD_WR_Ctrl
        CFI EndBlock cfiBlock2
//  265 } 
//  266 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function LCD_ExitSleep_ILI9327
        THUMB
//  267 void LCD_ExitSleep_ILI9327(void) 
//  268 { 
//  269   LCD_WR_Ctrl(0x11); 
LCD_ExitSleep_ILI9327:
        MOVS     R0,#+17
        Nop      
        CFI EndBlock cfiBlock3
        REQUIRE LCD_WR_Ctrl
        ;; // Fall through to label LCD_WR_Ctrl
//  270 }
//  271 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function LCD_WR_Ctrl
        THUMB
//  272 void LCD_WR_Ctrl(u16 Reg) 
//  273 {
//  274   LCD_RS_LOW();
LCD_WR_Ctrl:
        LDR.W    R1,??DataTable17  ;; 0x40011410
        MOV      R2,#+4096
        STR      R2,[R1, #+4]
//  275   LCD_PORT = Reg;        //Reg. Addr.
        MOV      R1,#+1610612736
        STRH     R0,[R1, #+0]
//  276   LCD_RS_HIGH();
        LDR.W    R0,??DataTable17  ;; 0x40011410
        STR      R2,[R0, #+0]
//  277 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function LCD_RD_Type
        THUMB
//  278 void LCD_RD_Type(void) 
//  279 { 
LCD_RD_Type:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  280   LCD_WR_Ctrl(0xEF);
        MOVS     R0,#+239
        BL       LCD_WR_Ctrl
//  281   LCD_Type  = (LCD_PORT&0xFF);
        MOV      R0,#+1610612736
        LDRH     R0,[R0, #+0]
//  282   LCD_Type  = (LCD_PORT&0xFF)<<24;
        MOV      R0,#+1610612736
        LDRH     R0,[R0, #+0]
//  283   LCD_Type |= (LCD_PORT&0xFF)<<16;
        MOV      R1,#+1610612736
        LDRH     R1,[R1, #+0]
//  284   LCD_Type |= (LCD_PORT&0xFF)<<8;
        MOV      R2,#+1610612736
        LDRH     R2,[R2, #+0]
//  285   LCD_Type |= (LCD_PORT&0xFF);
        LSLS     R1,R1,#+24
        LSRS     R1,R1,#+8
        ORR      R0,R1,R0, LSL #+24
        UXTB     R1,R2
        ORR      R0,R0,R1, LSL #+8
        MOV      R1,#+1610612736
        LDRH     R1,[R1, #+0]
        UXTB     R1,R1
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable14  ;; LCD_Type
        STR      R0,[R1, #+0]
//  286 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock5
//  287 /*
//  288 u16 LCD_RD_Data(void) 
//  289 {
//  290   u16 Data;
//  291   
//  292   Data  = LCD_PORT; 
//  293   Data  = LCD_PORT; 
//  294   return Data;      
//  295 }
//  296 */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Get_Pixl
        THUMB
//  297 u16 Get_Pixl(void)
//  298 { 
Get_Pixl:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  299   u16 Data;
//  300   
//  301   if(LCD_Type == 0x02049327){
        LDR.N    R0,??DataTable14  ;; LCD_Type
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable15  ;; 0x2049327
        CMP      R0,R1
        BNE.N    ??Get_Pixl_0
//  302     LCD_WR_Ctrl(0x2E);
        MOVS     R0,#+46
        BL       LCD_WR_Ctrl
//  303 //    Data = LCD_GetPixl();
//  304     Data  = LCD_PORT; 
        MOV      R0,#+1610612736
        LDRH     R0,[R0, #+0]
//  305     Data  = LCD_PORT; 
        MOV      R0,#+1610612736
        LDRH     R4,[R0, #+0]
//  306     LCD_WR_Ctrl(0x2C);
        MOVS     R0,#+44
        BL       LCD_WR_Ctrl
        B.N      ??Get_Pixl_1
//  307   } else {
//  308     Data  = LCD_PORT; 
??Get_Pixl_0:
        MOV      R0,#+1610612736
        LDRH     R0,[R0, #+0]
//  309     Data  = LCD_PORT; 
        MOV      R0,#+1610612736
        LDRH     R4,[R0, #+0]
//  310 //    return LCD_GetPixl();
//  311   }
//  312   return Data;
??Get_Pixl_1:
        MOVS     R0,R4
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock6
//  313 }
//  314 
//  315 /*******************************************************************************
//  316  delayms: ���루mS����ʱ���� ����: ��ʱ�ȴ��ĺ�����ֵ����72MHz��Ƶ����£�
//  317 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function Delayms
        THUMB
//  318 void Delayms(u16 mS) 
//  319 { 
//  320   Delay_Cnt = mS;
Delayms:
        LDR.N    R1,??Delayms_0   ;; Delay_Cnt
        STRH     R0,[R1, #+0]
//  321   while (Delay_Cnt > 0){}
??Delayms_1:
        LDRH     R0,[R1, #+0]
        CMP      R0,#+0
        BNE.N    ??Delayms_1
//  322 }
        BX       LR               ;; return
        DATA
??Delayms_0:
        DC32     Delay_Cnt
        CFI EndBlock cfiBlock7
//  323 /*******************************************************************************
//  324  Point_SCR : ָ����ʾλ�� for R61509V LCD   ����: X��Y����  
//  325 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function Point_SCR
        THUMB
//  326 void Point_SCR(u16 x0, u16 y0)						
//  327 { 
Point_SCR:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R5,R0
        MOVS     R4,R1
//  328   __LCD_DMA_Ready();
        BL       __LCD_DMA_Ready
//  329   if(LCD_Type == 0x02049327){
        MOV      R6,#+1610612736
        LDR.N    R0,??DataTable14  ;; LCD_Type
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable15  ;; 0x2049327
        CMP      R0,R1
        BNE.N    ??Point_SCR_0
//  330     LCD_WR_Ctrl(0x2A);      // Block End X Address
        MOVS     R0,#+42
        BL       LCD_WR_Ctrl
//  331     LCD_PORT = (0x00); 
        MOVS     R0,#+0
        STRH     R0,[R6, #+0]
//  332     LCD_PORT = (y0 & 0xFF); 
        UXTB     R0,R4
        STRH     R0,[R6, #+0]
//  333     LCD_PORT = (0x00); 
        MOVS     R0,#+0
        STRH     R0,[R6, #+0]
//  334     LCD_PORT = (0xEF); 
        MOVS     R0,#+239
        STRH     R0,[R6, #+0]
//  335     LCD_WR_Ctrl(0x2B);      // Block End Y Address
        MOVS     R0,#+43
        BL       LCD_WR_Ctrl
//  336     LCD_PORT = (x0 >> 8); 
        LSRS     R0,R5,#+8
        STRH     R0,[R6, #+0]
//  337     LCD_PORT = (x0 & 0xFF); 
        UXTB     R0,R5
        STRH     R0,[R6, #+0]
//  338     LCD_PORT = (399 >> 8); 
        MOVS     R0,#+1
        STRH     R0,[R6, #+0]
//  339     LCD_PORT = (399 & 0xFF); 
        MOVS     R0,#+143
        STRH     R0,[R6, #+0]
//  340     LCD_WR_Ctrl(0x2C); 
        MOVS     R0,#+44
        BL       LCD_WR_Ctrl
        POP      {R4-R6,PC}
//  341   } else {
//  342     LCD_WR_REG(0x0200,y0);             
??Point_SCR_0:
        MOVS     R1,R4
        MOV      R0,#+512
        BL       LCD_WR_REG
//  343     LCD_WR_REG(0x0201,x0);             
        MOVS     R1,R5
        MOVW     R0,#+513
        BL       LCD_WR_REG
//  344     LCD_RS_LOW();
        LDR.N    R0,??DataTable17  ;; 0x40011410
        MOV      R1,#+4096
        STR      R1,[R0, #+4]
//  345     LCD_PORT = 0x0202;     //Reg. Addr.
        MOVW     R0,#+514
        STRH     R0,[R6, #+0]
//  346     LCD_RS_HIGH();
        LDR.N    R0,??DataTable17  ;; 0x40011410
        STR      R1,[R0, #+0]
//  347   }
//  348 }
??Point_SCR_1:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock8
//  349 /*******************************************************************************
//  350  Clear_Screen: ��LCD��ʾ����Ļ�� 
//  351 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function Clear_Screen
        THUMB
//  352 void Clear_Screen(u16 Color)						
//  353 { 
Clear_Screen:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  354   Fill_Buffer = Color;
        LDR.N    R5,??Clear_Screen_0  ;; Fill_Buffer
        STRH     R0,[R5, #+0]
//  355   Point_SCR(0, 0); 
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Point_SCR
//  356   __LCD_Fill(&Fill_Buffer,240*200);//Clear Half Screen
        MOVW     R4,#+48000
        MOVS     R1,R4
        MOVS     R0,R5
        BL       __LCD_Fill
//  357   __LCD_DMA_Ready();
        BL       __LCD_DMA_Ready
//  358   __LCD_Fill(&Fill_Buffer,240*200);//Clear Half Screen
        MOVS     R1,R4
        MOVS     R0,R5
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      __LCD_Fill
        Nop      
        DATA
??Clear_Screen_0:
        DC32     Fill_Buffer
        CFI EndBlock cfiBlock9
//  359 }
//  360 /*******************************************************************************
//  361  Display_Str: ��ָ��λ����ʾ�ַ���   ����: X��Y���꣬��ɫֵ����ʾģʽ���ַ��� 
//  362 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function Get_TAB_8x14
        THUMB
//  363 u16 Get_TAB_8x14(u8 Code, u16 Row)
//  364 {
//  365   return Char_TAB_8x14[((Code-0x22)*8)+Row];
Get_TAB_8x14:
        ADD      R0,R1,R0, LSL #+3
        LDR.N    R1,??Get_TAB_8x14_0  ;; Char_TAB_8x14
        ADD      R0,R1,R0, LSL #+1
        SUB      R0,R0,#+544
        LDRH     R0,[R0, #+0]
        BX       LR               ;; return
        Nop      
        DATA
??Get_TAB_8x14_0:
        DC32     Char_TAB_8x14
        CFI EndBlock cfiBlock10
//  366 }
//  367 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function Display_Str
        THUMB
//  368 void Display_Str(u16 x0, u16 y0, u16 Color, u8 Mode, u8 *s)
//  369 { 
Display_Str:
        PUSH     {R1,R4-R11,LR}
        CFI R14 Frame(CFA, -4)
        CFI R11 Frame(CFA, -8)
        CFI R10 Frame(CFA, -12)
        CFI R9 Frame(CFA, -16)
        CFI R8 Frame(CFA, -20)
        CFI R7 Frame(CFA, -24)
        CFI R6 Frame(CFA, -28)
        CFI R5 Frame(CFA, -32)
        CFI R4 Frame(CFA, -36)
        CFI CFA R13+40
        MOVS     R5,R0
        MOV      R11,R2
        MOVS     R4,R3
        LDR      R6,[SP, #+40]
//  370   signed short i, j, b; 
//  371   Point_SCR(x0, y0);
        BL       Point_SCR
//  372   for (j=0; j<14;++j){ 
        MOVS     R7,#+14
//  373     if(Mode==0) __LCD_SetPixl(BLACK);   //Normal replace Display
??Display_Str_0:
        CBNZ     R4,??Display_Str_1
        MOVS     R0,#+0
        BL       __LCD_SetPixl
        B.N      ??Display_Str_2
//  374     if(Mode==1) __LCD_SetPixl(Color);   //Inverse replace Display
??Display_Str_1:
        CMP      R4,#+1
        ITT      EQ 
        MOVEQ    R0,R11
        BLEQ     __LCD_SetPixl
//  375   }
??Display_Str_2:
        SUBS     R7,R7,#+1
        BNE.N    ??Display_Str_0
//  376   x0++;                            // ÿһ���ַ���ǰ����һ�հ��� 
        ADDS     R5,R5,#+1
        B.N      ??Display_Str_3
//  377   while (*s!=0) {
//  378     for(i=0;i<8;++i){
//  379       Point_SCR(x0+i, y0);
//  380       if((*s==0x20)||(*s==0x21)) b=0x0000;
//  381       else                       b=Get_TAB_8x14(*s, i);
//  382       if((*s==0x21)&&(i==4)) break;
//  383       for(j=0;j<14;++j){
//  384         if(b&0x04) {
//  385           if(Mode==0) __LCD_SetPixl(Color);
//  386           if(Mode==1) __LCD_SetPixl(BLACK);
//  387         } else {
//  388           if(Mode==0) __LCD_SetPixl(BLACK);
//  389           if(Mode==1) __LCD_SetPixl(Color);
//  390         }
//  391         b>>=1;
//  392       }
//  393     }
//  394     if(*s==0x21) x0 +=4;           //��ʾλ��ˮƽ����+4
//  395     else  x0 += 8;                 //��ʾλ��ˮƽ����+8
??Display_Str_4:
        ADDS     R5,R5,#+8
//  396     ++s;                           //�ַ���ָ��+1
??Display_Str_5:
        ADDS     R6,R6,#+1
??Display_Str_3:
        LDRB     R0,[R6, #+0]
        CMP      R0,#+0
        BEQ.N    ??Display_Str_6
        MOVS     R7,#+0
        MOV      R8,R5
??Display_Str_7:
        LDRH     R1,[SP, #+0]
        UXTH     R0,R8
        BL       Point_SCR
        LDRB     R0,[R6, #+0]
        CMP      R0,#+32
        BEQ.N    ??Display_Str_8
        CMP      R0,#+33
        BNE.N    ??Display_Str_9
??Display_Str_8:
        MOV      R9,#+0
        B.N      ??Display_Str_10
??Display_Str_9:
        UXTH     R1,R7
        BL       Get_TAB_8x14
        MOV      R9,R0
??Display_Str_10:
        LDRB     R0,[R6, #+0]
        CMP      R0,#+33
        BNE.N    ??Display_Str_11
        CMP      R7,#+4
        BEQ.N    ??Display_Str_12
??Display_Str_11:
        MOV      R10,#+14
??Display_Str_13:
        TST      R9,#0x4
        BEQ.N    ??Display_Str_14
        CBNZ     R4,??Display_Str_15
        MOV      R0,R11
??Display_Str_16:
        BL       __LCD_SetPixl
        B.N      ??Display_Str_17
??Display_Str_15:
        CMP      R4,#+1
        BNE.N    ??Display_Str_17
        MOVS     R0,#+0
        B.N      ??Display_Str_16
??Display_Str_14:
        CBNZ     R4,??Display_Str_18
        MOVS     R0,#+0
        BL       __LCD_SetPixl
        B.N      ??Display_Str_17
??Display_Str_18:
        CMP      R4,#+1
        ITT      EQ 
        MOVEQ    R0,R11
        BLEQ     __LCD_SetPixl
??Display_Str_17:
        LSL      R9,R9,#+16
        ASR      R9,R9,#+17
        SUBS     R10,R10,#+1
        BNE.N    ??Display_Str_13
        ADDS     R7,R7,#+1
        ADD      R8,R8,#+1
        CMP      R7,#+8
        BLT.N    ??Display_Str_7
        LDRB     R0,[R6, #+0]
        CMP      R0,#+33
        BNE.N    ??Display_Str_4
??Display_Str_12:
        ADDS     R5,R5,#+4
        B.N      ??Display_Str_5
//  397   }
//  398 }
??Display_Str_6:
        ADD      SP,SP,#+4
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        CFI EndBlock cfiBlock11
//  399 /*******************************************************************************
//  400  Display_Logo: ��ָ��λ����ʾ�̱�ͼ��   ����: X��Y���� 
//  401 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function Display_Logo
        THUMB
//  402 void Display_Logo(u16 x0, u16 y0)
//  403 { 
Display_Logo:
        PUSH     {R4-R11,LR}
        CFI R14 Frame(CFA, -4)
        CFI R11 Frame(CFA, -8)
        CFI R10 Frame(CFA, -12)
        CFI R9 Frame(CFA, -16)
        CFI R8 Frame(CFA, -20)
        CFI R7 Frame(CFA, -24)
        CFI R6 Frame(CFA, -28)
        CFI R5 Frame(CFA, -32)
        CFI R4 Frame(CFA, -36)
        CFI CFA R13+36
        SUB      SP,SP,#+36
        CFI CFA R13+72
//  404   u8 *Ptr;
//  405   u16 i, x, y, Color[16];
//  406 //  u32 b;
//  407   
//  408   Ptr = (u8*)INF_BASE;
//  409   x = x0;
        MOV      R11,R0
        MOV      R9,R11
//  410   y = y0;
        MOVS     R4,R1
//  411   for(i=0; i<16; i++){        // 0x36~0x75: ��ɫ��(ÿɫ4B,˳��ΪB,G,R,Alpha)
        ADD      R1,SP,#+0
        LDR.N    R2,??Display_Logo_0  ;; 0x803d836
        MOVS     R3,#+8
//  412     Color[i]=((Ptr[0x36 + i*4]>>3)<<11)+
//  413       ((Ptr[0x37 + i*4]>>2)<<5)+(Ptr[0x38 + i*4]>>3);
??Display_Logo_1:
        LDRB     R12,[R2, #+0]
        LSR      R12,R12,#+3
        LDRB     LR,[R2, #+1]
        LSR      LR,LR,#+2
        LSL      LR,LR,#+5
        ADD      R12,LR,R12, LSL #+11
        LDRB     LR,[R2, #+2]
        LSR      LR,LR,#+3
        ADD      R12,LR,R12
        STRH     R12,[R1], #+2
        LDRB     R12,[R2, #+4]
        LSR      R12,R12,#+3
        LDRB     LR,[R2, #+5]
        LSR      LR,LR,#+2
        LSL      LR,LR,#+5
        ADD      R12,LR,R12, LSL #+11
        LDRB     LR,[R2, #+6]
        LSR      LR,LR,#+3
        ADD      R12,LR,R12
        STRH     R12,[R1], #+2
//  414   }      
        ADDS     R2,R2,#+8
        SUBS     R3,R3,#+1
        BNE.N    ??Display_Logo_1
//  415   for(i=0; i<256*64/2; ++i){
        LDR.N    R1,??Display_Logo_0  ;; 0x803d836
        ADD      R5,R1,#+64
        MOV      R6,#+8192
        ADD      R10,R0,#+255
        MOV      R7,#+1610612736
        ADD      R8,SP,#+0
//  416     Point_SCR(x, y);
??Display_Logo_2:
        MOVS     R1,R4
        MOV      R0,R9
        BL       Point_SCR
//  417     LCD_PORT = Color[(Ptr[0x76 + i]&0xF0)>>4]; // �߰��ֽ�   
        LDRB     R0,[R5, #+0]
        ASRS     R0,R0,#+4
        LDRH     R0,[R8, R0, LSL #+1]
        STRH     R0,[R7, #+0]
//  418     x++;
        ADD      R9,R9,#+1
        UXTH     R9,R9
//  419     if(x > x0+255) { x = x0; y++;}
        CMP      R10,R9
        BGE.N    ??Display_Logo_3
        MOV      R9,R11
        ADDS     R4,R4,#+1
        UXTH     R4,R4
//  420     Point_SCR(x, y);
??Display_Logo_3:
        MOVS     R1,R4
        MOV      R0,R9
        BL       Point_SCR
//  421     LCD_PORT = Color[Ptr[0x76 + i]&0x0F];      // �Ͱ��ֽ�
        LDRB     R0,[R5, #+0]
        AND      R0,R0,#0xF
        LDRH     R0,[R8, R0, LSL #+1]
        STRH     R0,[R7, #+0]
//  422     x++;
        ADD      R9,R9,#+1
        UXTH     R9,R9
//  423     if(x > x0+255) { x = x0; y++;}
        CMP      R10,R9
        BGE.N    ??Display_Logo_4
        MOV      R9,R11
        ADDS     R4,R4,#+1
        UXTH     R4,R4
//  424   }
??Display_Logo_4:
        ADDS     R5,R5,#+1
        SUBS     R6,R6,#+1
        BNE.N    ??Display_Logo_2
//  425 }
        ADD      SP,SP,#+36
        CFI CFA R13+36
        POP      {R4-R11,PC}      ;; return
        DATA
??Display_Logo_0:
        DC32     0x803d836
        CFI EndBlock cfiBlock12
//  426 /*******************************************************************************
//  427  LCD_Set_Block: 
//  428 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function LCD_Set_Block
        THUMB
//  429 void LCD_Set_Block(u16 x1, u16 x2, u16 y1, u16 y2) 
//  430 {
LCD_Set_Block:
        PUSH     {R4-R8,LR}
        CFI R14 Frame(CFA, -4)
        CFI R8 Frame(CFA, -8)
        CFI R7 Frame(CFA, -12)
        CFI R6 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        MOVS     R6,R0
        MOVS     R7,R1
        MOVS     R5,R2
        MOVS     R4,R3
//  431   if(LCD_Type == 0x02049327){
        MOV      R8,#+1610612736
        LDR.N    R0,??DataTable14  ;; LCD_Type
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable15  ;; 0x2049327
        CMP      R0,R1
        BNE.N    ??LCD_Set_Block_0
//  432     LCD_WR_Ctrl(0x2A);      // Block End X Address
        MOVS     R0,#+42
        BL       LCD_WR_Ctrl
//  433     LCD_PORT = (y1 >> 8); 
        LSRS     R0,R5,#+8
        STRH     R0,[R8, #+0]
//  434     LCD_PORT = (y1 & 0xFF); 
        UXTB     R0,R5
        STRH     R0,[R8, #+0]
//  435     LCD_PORT = (y2 >> 8); 
        LSRS     R0,R4,#+8
        STRH     R0,[R8, #+0]
//  436     LCD_PORT = (y2 & 0xFF); 
        UXTB     R0,R4
        STRH     R0,[R8, #+0]
//  437     LCD_WR_Ctrl(0x2B);      // Block End Y Address
        MOVS     R0,#+43
        BL       LCD_WR_Ctrl
//  438     LCD_PORT = (x1 >> 8); 
        LSRS     R0,R6,#+8
        STRH     R0,[R8, #+0]
//  439     LCD_PORT = (x1 & 0xFF); 
        UXTB     R0,R6
        STRH     R0,[R8, #+0]
//  440     LCD_PORT = (x2 >> 8); 
        LSRS     R0,R7,#+8
        STRH     R0,[R8, #+0]
//  441     LCD_PORT = (x2 & 0xFF); 
        UXTB     R0,R7
        STRH     R0,[R8, #+0]
//  442     LCD_WR_Ctrl(0x2C); 
        MOVS     R0,#+44
        BL       LCD_WR_Ctrl
        B.N      ??LCD_Set_Block_1
//  443   } else {
//  444     LCD_WR_REG(0x0211, y2);      // Block End X Address
??LCD_Set_Block_0:
        MOVS     R1,R4
        MOVW     R0,#+529
        BL       LCD_WR_REG
//  445     LCD_WR_REG(0x0213, x2);      // Block End Y Address
        MOVS     R1,R7
        MOVW     R0,#+531
        BL       LCD_WR_REG
//  446 
//  447     LCD_WR_REG(0x0210, y1);      // Block Start X Address
        MOVS     R1,R5
        MOV      R0,#+528
        BL       LCD_WR_REG
//  448     LCD_WR_REG(0x0212, x1);      // Block Start Y Address
        MOVS     R1,R6
        MOVW     R0,#+530
        BL       LCD_WR_REG
//  449   
//  450     LCD_WR_REG(0x0200, y1);
        MOVS     R1,R5
        MOV      R0,#+512
        BL       LCD_WR_REG
//  451     LCD_WR_REG(0x0201, x1);
        MOVS     R1,R6
        MOVW     R0,#+513
        BL       LCD_WR_REG
//  452   
//  453     LCD_RS_LOW();
        LDR.N    R0,??DataTable17  ;; 0x40011410
        MOV      R1,#+4096
        STR      R1,[R0, #+4]
//  454     LCD_PORT = 0x0202;             //GRAM Reg. Addr.
        MOVW     R0,#+514
        STRH     R0,[R8, #+0]
//  455     LCD_RS_HIGH();
        LDR.N    R0,??DataTable17  ;; 0x40011410
        STR      R1,[R0, #+0]
//  456   }
//  457 }
??LCD_Set_Block_1:
        POP      {R4-R8,PC}       ;; return
        CFI EndBlock cfiBlock13

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14:
        DC32     LCD_Type

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable15:
        DC32     0x2049327

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     0x40011410

        END
//  458 /******************************** END OF FILE *********************************/
// 
//     6 bytes in section .bss
// 1 488 bytes in section .rodata
// 1 812 bytes in section .text
// 
// 1 812 bytes of CODE  memory
// 1 488 bytes of CONST memory
//     6 bytes of DATA  memory
//
//Errors: none
//Warnings: none
