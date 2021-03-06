///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:39:14 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\FWLib\src\stm32f10x_lib.c                     /
//    Command line =  E:\DS0203\FWLib\src\stm32f10x_lib.c -lA                 /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\Obj\ --debug         /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\stm32f10x_lib.s /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_lib


        END
// E:\DS0203\FWLib\src\stm32f10x_lib.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_lib.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.3
//    5 * Date               : 09/22/2008
//    6 * Description        : This file provides all peripherals pointers initialization.
//    7 ********************************************************************************
//    8 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//    9 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   10 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   11 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   12 * CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   13 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   14 *******************************************************************************/
//   15 
//   16 #define EXT
//   17 
//   18 /* Includes ------------------------------------------------------------------*/
//   19 #include "stm32f10x_lib.h"
//   20 
//   21 /* Private typedef -----------------------------------------------------------*/
//   22 /* Private define ------------------------------------------------------------*/
//   23 /* Private macro -------------------------------------------------------------*/
//   24 /* Private variables ---------------------------------------------------------*/
//   25 /* Private function prototypes -----------------------------------------------*/
//   26 /* Private functions ---------------------------------------------------------*/
//   27 
//   28 #ifdef DEBUG
//   29 /*******************************************************************************
//   30 * Function Name  : debug
//   31 * Description    : This function initialize peripherals pointers.
//   32 * Input          : None
//   33 * Output         : None
//   34 * Return         : None
//   35 *******************************************************************************/
//   36 void debug(void)
//   37 {
//   38 
//   39 /************************************* ADC ************************************/
//   40 #ifdef _ADC1
//   41   ADC1 = (ADC_TypeDef *)  ADC1_BASE;
//   42 #endif /*_ADC1 */
//   43 
//   44 #ifdef _ADC2
//   45   ADC2 = (ADC_TypeDef *)  ADC2_BASE;
//   46 #endif /*_ADC2 */
//   47 
//   48 #ifdef _ADC3
//   49   ADC3 = (ADC_TypeDef *)  ADC3_BASE;
//   50 #endif /*_ADC3 */
//   51 
//   52 /************************************* BKP ************************************/
//   53 #ifdef _BKP
//   54   BKP = (BKP_TypeDef *)  BKP_BASE;
//   55 #endif /*_BKP */
//   56 
//   57 /************************************* CAN ************************************/
//   58 #ifdef _CAN
//   59   CAN = (CAN_TypeDef *)  CAN_BASE;
//   60 #endif /*_CAN */
//   61 
//   62 /************************************* CRC ************************************/
//   63 #ifdef _CRC
//   64   CRC = (CRC_TypeDef *)  CRC_BASE;
//   65 #endif /*_CRC */
//   66 
//   67 /************************************* DAC ************************************/
//   68 #ifdef _DAC
//   69   DAC = (DAC_TypeDef *)  DAC_BASE;
//   70 #endif /*_DAC */
//   71 
//   72 /************************************* DBGMCU**********************************/
//   73 #ifdef _DBGMCU
//   74   DBGMCU = (DBGMCU_TypeDef *)  DBGMCU_BASE;
//   75 #endif /*_DBGMCU */
//   76 
//   77 /************************************* DMA ************************************/
//   78 #ifdef _DMA
//   79   DMA1 = (DMA_TypeDef *)  DMA1_BASE;
//   80   DMA2 = (DMA_TypeDef *)  DMA2_BASE;
//   81 #endif /*_DMA */
//   82 
//   83 #ifdef _DMA1_Channel1
//   84   DMA1_Channel1 = (DMA_Channel_TypeDef *)  DMA1_Channel1_BASE;
//   85 #endif /*_DMA1_Channel1 */
//   86 
//   87 #ifdef _DMA1_Channel2
//   88   DMA1_Channel2 = (DMA_Channel_TypeDef *)  DMA1_Channel2_BASE;
//   89 #endif /*_DMA1_Channel2 */
//   90 
//   91 #ifdef _DMA1_Channel3
//   92   DMA1_Channel3 = (DMA_Channel_TypeDef *)  DMA1_Channel3_BASE;
//   93 #endif /*_DMA1_Channel3 */
//   94 
//   95 #ifdef _DMA1_Channel4
//   96   DMA1_Channel4 = (DMA_Channel_TypeDef *)  DMA1_Channel4_BASE;
//   97 #endif /*_DMA1_Channel4 */
//   98 
//   99 #ifdef _DMA1_Channel5
//  100   DMA1_Channel5 = (DMA_Channel_TypeDef *)  DMA1_Channel5_BASE;
//  101 #endif /*_DMA1_Channel5 */
//  102 
//  103 #ifdef _DMA1_Channel6
//  104   DMA1_Channel6 = (DMA_Channel_TypeDef *)  DMA1_Channel6_BASE;
//  105 #endif /*_DMA1_Channel6 */
//  106 
//  107 #ifdef _DMA1_Channel7
//  108   DMA1_Channel7 = (DMA_Channel_TypeDef *)  DMA1_Channel7_BASE;
//  109 #endif /*_DMA1_Channel7 */
//  110 
//  111 #ifdef _DMA2_Channel1
//  112   DMA2_Channel1 = (DMA_Channel_TypeDef *)  DMA2_Channel1_BASE;
//  113 #endif /*_DMA2_Channel1 */
//  114 
//  115 #ifdef _DMA2_Channel2
//  116   DMA2_Channel2 = (DMA_Channel_TypeDef *)  DMA2_Channel2_BASE;
//  117 #endif /*_DMA2_Channel2 */
//  118 
//  119 #ifdef _DMA2_Channel3
//  120   DMA2_Channel3 = (DMA_Channel_TypeDef *)  DMA2_Channel3_BASE;
//  121 #endif /*_DMA2_Channel3 */
//  122 
//  123 #ifdef _DMA2_Channel4
//  124   DMA2_Channel4 = (DMA_Channel_TypeDef *)  DMA2_Channel4_BASE;
//  125 #endif /*_DMA2_Channel4 */
//  126 
//  127 #ifdef _DMA2_Channel5
//  128   DMA2_Channel5 = (DMA_Channel_TypeDef *)  DMA2_Channel5_BASE;
//  129 #endif /*_DMA2_Channel5 */
//  130 
//  131 /************************************* EXTI ***********************************/
//  132 #ifdef _EXTI
//  133   EXTI = (EXTI_TypeDef *)  EXTI_BASE;
//  134 #endif /*_EXTI */
//  135 
//  136 /************************************* FLASH and Option Bytes *****************/
//  137 #ifdef _FLASH
//  138   FLASH = (FLASH_TypeDef *)  FLASH_R_BASE;
//  139   OB = (OB_TypeDef *)        OB_BASE;
//  140 #endif /*_FLASH */
//  141 
//  142 /************************************* FSMC ***********************************/
//  143 #ifdef _FSMC
//  144   FSMC_Bank1 = (FSMC_Bank1_TypeDef *)    FSMC_Bank1_R_BASE;
//  145   FSMC_Bank1E = (FSMC_Bank1E_TypeDef *)  FSMC_Bank1E_R_BASE;  
//  146   FSMC_Bank2 = (FSMC_Bank2_TypeDef *)    FSMC_Bank2_R_BASE; 
//  147   FSMC_Bank3 = (FSMC_Bank3_TypeDef *)    FSMC_Bank3_R_BASE;
//  148   FSMC_Bank4 = (FSMC_Bank4_TypeDef *)    FSMC_Bank4_R_BASE;
//  149 #endif /*_FSMC */
//  150 
//  151 /************************************* GPIO ***********************************/
//  152 #ifdef _GPIOA
//  153   GPIOA = (GPIO_TypeDef *)  GPIOA_BASE;
//  154 #endif /*_GPIOA */
//  155 
//  156 #ifdef _GPIOB
//  157   GPIOB = (GPIO_TypeDef *)  GPIOB_BASE;
//  158 #endif /*_GPIOB */
//  159 
//  160 #ifdef _GPIOC
//  161   GPIOC = (GPIO_TypeDef *)  GPIOC_BASE;
//  162 #endif /*_GPIOC */
//  163 
//  164 #ifdef _GPIOD
//  165   GPIOD = (GPIO_TypeDef *)  GPIOD_BASE;
//  166 #endif /*_GPIOD */
//  167 
//  168 #ifdef _GPIOE
//  169   GPIOE = (GPIO_TypeDef *)  GPIOE_BASE;
//  170 #endif /*_GPIOE */
//  171 
//  172 #ifdef _GPIOF
//  173   GPIOF = (GPIO_TypeDef *)  GPIOF_BASE;
//  174 #endif /*_GPIOF */
//  175 
//  176 #ifdef _GPIOG
//  177   GPIOG = (GPIO_TypeDef *)  GPIOG_BASE;
//  178 #endif /*_GPIOG */
//  179 
//  180 #ifdef _AFIO
//  181   AFIO = (AFIO_TypeDef *)  AFIO_BASE;
//  182 #endif /*_AFIO */
//  183 
//  184 /************************************* I2C ************************************/
//  185 #ifdef _I2C1
//  186   I2C1 = (I2C_TypeDef *)  I2C1_BASE;
//  187 #endif /*_I2C1 */
//  188 
//  189 #ifdef _I2C2
//  190   I2C2 = (I2C_TypeDef *)  I2C2_BASE;
//  191 #endif /*_I2C2 */
//  192 
//  193 /************************************* IWDG ***********************************/
//  194 #ifdef _IWDG
//  195   IWDG = (IWDG_TypeDef *) IWDG_BASE;
//  196 #endif /*_IWDG */
//  197 
//  198 /************************************* NVIC ***********************************/
//  199 #ifdef _NVIC
//  200   NVIC = (NVIC_TypeDef *)  NVIC_BASE;
//  201   SCB = (SCB_TypeDef *)  SCB_BASE;
//  202 #endif /*_NVIC */
//  203 
//  204 /************************************* PWR ************************************/
//  205 #ifdef _PWR
//  206   PWR = (PWR_TypeDef *)  PWR_BASE;
//  207 #endif /*_PWR */
//  208 
//  209 /************************************* RCC ************************************/
//  210 #ifdef _RCC
//  211   RCC = (RCC_TypeDef *)  RCC_BASE;
//  212 #endif /*_RCC */
//  213 
//  214 /************************************* RTC ************************************/
//  215 #ifdef _RTC
//  216   RTC = (RTC_TypeDef *)  RTC_BASE;
//  217 #endif /*_RTC */
//  218 
//  219 /************************************* SDIO ***********************************/
//  220 #ifdef _SDIO
//  221   SDIO = (SDIO_TypeDef *)  SDIO_BASE;
//  222 #endif /*_SDIO */
//  223 
//  224 /************************************* SPI ************************************/
//  225 #ifdef _SPI1
//  226   SPI1 = (SPI_TypeDef *)  SPI1_BASE;
//  227 #endif /*_SPI1 */
//  228 
//  229 #ifdef _SPI2
//  230   SPI2 = (SPI_TypeDef *)  SPI2_BASE;
//  231 #endif /*_SPI2 */
//  232 
//  233 #ifdef _SPI3
//  234   SPI3 = (SPI_TypeDef *)  SPI3_BASE;
//  235 #endif /*_SPI3 */
//  236 
//  237 /************************************* SysTick ********************************/
//  238 #ifdef _SysTick
//  239   SysTick = (SysTick_TypeDef *)  SysTick_BASE;
//  240 #endif /*_SysTick */
//  241 
//  242 /************************************* TIM ************************************/
//  243 #ifdef _TIM1
//  244   TIM1 = (TIM_TypeDef *)  TIM1_BASE;
//  245 #endif /*_TIM1 */
//  246 
//  247 #ifdef _TIM2
//  248   TIM2 = (TIM_TypeDef *)  TIM2_BASE;
//  249 #endif /*_TIM2 */
//  250 
//  251 #ifdef _TIM3
//  252   TIM3 = (TIM_TypeDef *)  TIM3_BASE;
//  253 #endif /*_TIM3 */
//  254 
//  255 #ifdef _TIM4
//  256   TIM4 = (TIM_TypeDef *)  TIM4_BASE;
//  257 #endif /*_TIM4 */
//  258 
//  259 #ifdef _TIM5
//  260   TIM5 = (TIM_TypeDef *)  TIM5_BASE;
//  261 #endif /*_TIM5 */
//  262 
//  263 #ifdef _TIM6
//  264   TIM6 = (TIM_TypeDef *)  TIM6_BASE;
//  265 #endif /*_TIM6 */
//  266 
//  267 #ifdef _TIM7
//  268   TIM7 = (TIM_TypeDef *)  TIM7_BASE;
//  269 #endif /*_TIM7 */
//  270 
//  271 #ifdef _TIM8
//  272   TIM8 = (TIM_TypeDef *)  TIM8_BASE;
//  273 #endif /*_TIM8 */
//  274 
//  275 /************************************* USART **********************************/
//  276 #ifdef _USART1
//  277   USART1 = (USART_TypeDef *) USART1_BASE;
//  278 #endif /*_USART1 */
//  279 
//  280 #ifdef _USART2
//  281   USART2 = (USART_TypeDef *) USART2_BASE;
//  282 #endif /*_USART2 */
//  283 
//  284 #ifdef _USART3
//  285   USART3 = (USART_TypeDef *) USART3_BASE;
//  286 #endif /*_USART3 */
//  287 
//  288 #ifdef _UART4
//  289   UART4 = (USART_TypeDef *) UART4_BASE;
//  290 #endif /*_UART4 */
//  291 
//  292 #ifdef _UART5
//  293   UART5 = (USART_TypeDef *) UART5_BASE;
//  294 #endif /*_UART5 */
//  295 
//  296 /************************************* WWDG ***********************************/
//  297 #ifdef _WWDG
//  298   WWDG = (WWDG_TypeDef *)  WWDG_BASE;
//  299 #endif /*_WWDG */
//  300 }
//  301 #endif  /* DEBUG*/
//  302 
//  303 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 
// 0 bytes of memory
//
//Errors: none
//Warnings: none
