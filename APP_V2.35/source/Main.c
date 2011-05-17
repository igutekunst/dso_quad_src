/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : main.c  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#include "Interrupt.h"
#include "Function.h"
#include "Calibrat.h"
#include "Process.h"
#include "Ident.h"
#include "Draw.h"
#include "BIOS.h"
#include "Menu.h"
#include "File.h"

/*******************************************************************************
�汾�޸�˵��
APP V2.30: �Ӹð汾���ټ���PCB_V2.6���°汾������
           �Ӹð汾���ټ���SYS_V1.31���°汾
           ���߶�ʱ�޸�Ϊ600��(Main.c)
           �޸ļ�������µ�SYS�⺯��(BIOS.s)
           �޸��˿�����Ϣ��ʾ����(Main.c)
APP V2.31: �����˿���ʶ��FPGA���������������б�(Main.c)
           ������LicenceȨ�޹����ܵ�Demo������(Ident.c,Main.c)
           �޸���ģ��ͨ��У�����ܵĽ�����˳���ز���(calibrat.c)
           ������144MHz�������ģʽ�µ���ع���(Process.c)
APP V2.32  �Ӹð汾��ɲ���ʹ��IAR 4.42��5.0�汾
           Դ����û�Ķ����������ļ��С�IAR_V5_Prpject
APP V2.33  �޸���ɨ��ʱ��<1uSʱ����ʾˢ�µ�BUG(Process.c)
           �޸�����У׼״̬�£�������ʾ��Ϣ��BUG(Calibrat.c)
APP V2.34  ��Ϊ��ͨ������У׼(Calibrat.c & Main.c)
           �޸���У׼��ѡ��Ĳ�����ʽ(Calibrat.c)
APP V2.35  �޸���У׼�����е�BUG(Calibrat.c)
           �޸���ɨ��ʱ��<5uSʱ����ͣ���˵�BUG(Process.c)
           �Ż�����ʾ���ݴ������(Process.c)
           ������ģ��ͨ���Զ����ƽ�⹦��(Main.c,Process.c,Calibrat.c)
*******************************************************************************/

#define APP_VERSION       "     DS203 Mini DSO APP Ver 2.35      "

uc8 PROJECT_STR[20] = "Demo PROG. Ver 1.00";

/*******************************************************************************
  main : Main routine.
*******************************************************************************/
int main(void)
{ 
  u32 i, Licence;
  u16 Count_FPS, Second, Offset, Result;
  
  NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x0C000);   // For Application #1
//NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x14000);   // For Application #2
//NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x1C000);   // For Application #3
//NVIC_SetVectorTable(NVIC_VectTab_FLASH, 0x24000);   // For Application #4
  
//Note: �� IAR_V4.x ����ʱ����� App#n ��Ҫͬʱ�޸� lnkarm.xcl �ļ��еĶ�Ӧ�� 
//      �� IAR_V5.x ����ʱ����� App#n ��Ҫͬʱ�޸� xxxxxx.icf �ļ��еĶ�Ӧ�� 
  
  __USB_Init();
  
  if(__Get(FPGA_OK)== 0){
    __Display_Str(6*8, 30, YEL, PRN, "      FPGA configuration error       ");
    while (1){};
  }
  
  __Display_Str(48, 50, WHT, PRN, APP_VERSION);
  Y_Attr = (Y_attr*)__Get(VERTICAL);     
  X_Attr = (X_attr*)__Get(HORIZONTAL);
  G_Attr = (G_attr*)__Get(GLOBAL);
  T_Attr = (T_attr*)__Get(TRIGGER);
  Load_Attr();
  Load_Parameter();            // ��ȡԤ�迪����������ֵY_Attr��
  
/*--------------------------- LICENCE_CTRL_DEMO --------------------------------
  Offset = Seek_Proj(PROJECT_ID);
  if(Offset >= 2048){                          // Project ID not found
    Offset = Seek_Blank();
    if(Offset == 2048){  
      __Display_Str(6*8, 50, GRN, PRN,   "         Licence record full         ");
      while (1){};
    } else {
      Result  = Add_Proj(PROJECT_ID, Offset);  // Set project ID
      Result &= Add_Cnt(DEMOCNT, Offset);      // Set max demo run counter      
      Result &= Add_Str((u32)PROJECT_STR, Offset); 
      if(Result != 1){                                
        __Display_Str(6*8,50,GRN, PRN,   "       Project ID writen error       ");
        Delayms(500);
      }
    }
  }
  Licence = Get_Lic(Offset);                   // Get project licence record
  if(__Ident(DEVELOPER_ID, PROJECT_ID, Licence)!= 1){
    __Display_Str(6*8, 50, GRN, PRN,   "Please input project licence:00000000");
    Licence = Input_Lic((6+29)*8, 50);         // Input Licence
    if(__Ident(DEVELOPER_ID, PROJECT_ID, Licence)!=1)  Result = 0;
    else{                                      // Licence correct
      Result  = Add_Lic(Licence, Offset);            
      if(Result == 1)                                
        __Display_Str(6*8,50,GRN, PRN, "          Licence writen ok          ");
      else  
        __Display_Str(6*8,50,GRN, PRN, "         Licence writen error        ");
      Delayms(500);
    }
    if(Result != 1){
      __Display_Str(6*8, 30, GRN, PRN, "      Push any key to next step      ");
      while(Key_Buffer == 0){};
    }
  }
//  --------------------------------------------------------------------------*/
  
  Beep_mS = 500;
  Balance();
//  Delayms(2000); 
  App_init();
  Key_Buffer=0;
  
//--------------------------------- ��ѭ�� ------------------------------------- 
  while (1){
    if(PD_Cnt == 0){
      __Set(BACKLIGHT, 0);     // �رձ���
      __Set(STANDBY, EN);      // ����ʡ��״̬  
    } else {
      Synchro();                              // ͬ����ʾ�����켣��������
      Count_FPS++;
      if(Second != Sec_Cnt) {
        Second = Sec_Cnt;
        Result_FPS = Count_FPS;
        Count_FPS = 0;
        Update_Battery();
        for(i=0; i<9; ++i)  Display_Value(i); // ÿ��ˢ�²���ֵ        
      }
      Display_Meter();
      Display_Title();
      if(Update){                             // ����������Ҫˢ�µ���Ŀ
        Update_Range();
        Update_Base();
        Update_Output();
        Update_Trig();
        Update_Mark();
        __Set(BACKLIGHT, 10*(Title[BK_LIGHT][CLASS].Value+1));
        if(Current != FILE) Update_View_Area();
        _D_V_Source.Flag |= UPDAT;            // Updat delta V 
        _Delta_V.Flag    |= UPDAT; 
        _Delta_T.Flag    |= UPDAT;            // Updat delta T 
        Update = 0;                           // Update finish
      } 
      Blink = 0;
    }
//------------------------------ ��������ѭ�� ---------------------------------- 
    if(Key_Buffer) { 
      if(PD_Cnt == 0)  App_init();          // �˳�ʡ��״̬
      PD_Cnt = 600;                         // 600��
      if(Key_Buffer == KEY_P){
        _State.Value = 1-_State.Value;                 // "RUN/HOLD" ״̬����
        _State.Flag |= UPDAT;                          // ����Ӧ�ĸ��±�־
        if(_Mode == SIGN){
          for(i=0; i<4*X_SIZE; ++i)  TrackBuff[i] = 0; // ����ɵ���ʾ����
          __Set(FIFO_CLR, W_PTR);                      // FIFOдָ�븴λ
        }
      }
      if(Key_Buffer== KEY2){
        if((Current == TRACK1)||(Current == TRACK2)){
          Delay_Cnt = 2000;
          while (Delay_Cnt > 0){
            if((__Get(KEY_STATUS)& KEY2_STATUS)!=0) break; 
          }
          if(Delay_Cnt == 0)  Calibrat(Current);             // ģ��ͨ��У׼
        }
      }
      if(Key_Buffer== KEY3){
        Save_Parameter(0);                             // ���浱ǰ�������ò���    
        if(Current != FILE){
          Print_Str(91, 0, 0x0405, PRN, "! Save the current setting !");
          Delayms(500);
        } 
      }
      if(Key_Buffer== KEY4){
        if(Current == FILE){
          Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " >   ");
          if(_Curr[0].Value == SAVE){
            if(_Curr[2].Value == BMP)       i = Save_Bmp(_Curr[1].Value);
            else if(_Curr[2].Value == DAT)  i = Save_Dat(_Curr[1].Value);
//            else if(_Curr[2].Value == CSV)  i = Save_CSV(_Curr[1].Value);
          } else if(_Curr[0].Value == LOAD) i = Load_Dat(_Curr[1].Value);
          if(i != 0) Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " ERR "); 
          else       Print_Str(230, 0, (SCRN<<8)+ TEXT1, PRN, " OK  ");
          Delayms(500);
          _Curr[2].Flag |= UPDAT;
        }  
      }             
      if(Key_Buffer == K_ITEM_DEC){ //------------------ "Item-" Key
        if(Current < METER_0){
          _Curr[_Det].Flag |= UPDAT;
          if(Current == TRACK1)  Current = VOLUME;
          else                   Current --;
          if(Current == RUNNING) Current --;               // Jump over Item 4
          if(_Det >2)  _Det =0;
          _Curr[_Det].Flag |= BLINK;
          _Curr[0].Flag |= UPDAT;
          _Curr[1].Flag |= UPDAT;
          _Curr[2].Flag |= UPDAT;
          _Curr[3].Flag |= UPDAT;
        } else {
          Meter[Current-METER_0].Flag |= UPDAT; 
          if(Current == METER_0) Current = METER_8;
          else                   Current --;
          Meter[Current-METER_0].Flag |= BLINK;
        }
      }
      if(Key_Buffer == K_ITEM_S){ //------------------ "Item_Select"  Key
        if(Current < METER_0)  Current = METER_0;
        else                   Current = TRACK1;
      }
      if(Key_Buffer == K_ITEM_INC){ //------------------ "Item+" Key
        if(Current < METER_0){
          _Curr[_Det].Flag |= UPDAT;
          if(Current == VOLUME)  Current = TRACK1;
          else                   Current ++;
          if(Current == RUNNING) Current ++;              // Jump over RUNNING
          if(_Det >2)    _Det =0;
          _Curr[_Det].Flag |= BLINK;
          _Curr[0].Flag |= UPDAT;
          _Curr[1].Flag |= UPDAT;
          _Curr[2].Flag |= UPDAT;
          _Curr[3].Flag |= UPDAT;
        } else {
          Meter[Current-METER_0].Flag |= UPDAT;  
          if(Current == METER_8) Current  = METER_0;
          else                   Current ++;
          Meter[Current-METER_0].Flag |= BLINK;
        }
      }
      if(Key_Buffer == K_INDEX_DEC){ //--------------------- "Index-" Key 
        if(Current < METER_0){
          if((Current == TRIGG)&&(Detail[Current]==2)){         // ������ƽ����
            if(V_Trigg[_Trigg[SOURCE].Value].Value > MIN_Y+4) 
              V_Trigg[_Trigg[SOURCE].Value].Value--;
          } else if((Current == BK_LIGHT)||(Current == VOLUME)){// �������������
            if(_Curr[1].Value > 0)   _Curr[1].Value--;
          } else if((Current == T_BASE)&&(_Det == XPOSI)){      // X_POSI����
            if(_Curr[_Det].Value > 30) _Curr[_Det].Value -= 30; 
            else if(_Curr[_Det].Value > 0) _Curr[_Det].Value--;
            _X_View.Flag |= UPDAT;                              // ˢ��X_View
          } else {                                              // ��ǰ��Ϊ����
            if(_Curr[_Det].Value > 0) _Curr[_Det].Value--; 
            else if(_Curr[_Det].MARK & CIRC) _Curr[_Det].Value =_Curr[_Det].Limit;
          }
          if((Current == T_BASE)&&(_Det == MODE)){     // T_BASE MODE ѡ��
            Title[RUNNING][STATE].Value = RUN;         // STATE = RUNNING 
            Title[RUNNING][STATE].Flag |= UPDAT;       // ˢ�� RUNNING STATE
          }
          if(((Current == OUTPUT)&&(Title[OUTPUT][SOURCE].Value != DIGI))&&
            (Title[OUTPUT][FRQN].Value > 10)) 
            Title[OUTPUT][FRQN].Value = 10;            // ģ���ź�Ƶ������Ϊ20KHz
          if((Current == FILE)&&(_Curr[0].Value == 1)) 
            _Curr[2].Value = 1;                        // ֻ��Load Dat�ļ�
          _Curr[0].Flag |= UPDAT;
          _Curr[1].Flag |= UPDAT;
          _Curr[2].Flag |= UPDAT;
          _Curr[3].Flag |= UPDAT;
        } else {
          Meter[Current-METER_0].Flag |= UPDAT;
          if(Meter[Current-METER_0].Item  > VBT) 
            Meter[Current-METER_0].Item -= 1;          // �ı������Ŀ 
          else                     
            Meter[Current-METER_0].Item  = MIN;
          if(Meter[Current-METER_0].Item == FPS) 
            Meter[Current-METER_0].Track = 4;
          if(Meter[Current-METER_0].Item == MIN) 
            Meter[Current-METER_0].Track = 0;
        }
      }
      if(Key_Buffer == K_INDEX_S){ //----------------- "Index_Select" Key
        if(Current < METER_0){                         // �ı�Detail
          _Curr[_Det].Flag |= UPDAT;
          if(_Det < 3)    _Det += 1;
          else            _Det  = 0;
          if(_Curr[_Det].MARK & NOT)                        _Det  = 0; 
          if(_Curr[_Det].MARK & NUM2)                       _Det  = 0; 
          if((_Curr[_Det].MARK & NUM3)&&(Current != FILE))  _Det  = 0;  
          _Curr[_Det].Flag |= BLINK;
        } else {                                       // �ı��������
          Meter[Current-METER_0].Flag |= UPDAT;
          if(Meter[Current-METER_0].Track <  TRACK4) 
            Meter[Current-METER_0].Track += 1;
          if(Meter[Current-METER_0].Track == TRACK4) 
            Meter[Current-METER_0].Track  = 0;
        }
      }
      if(Key_Buffer == K_INDEX_INC){ //--------------------- "Index+" Key 
        if(Current < METER_0){
          if((Current == TRIGG)&&(Detail[Current]==2)){         // ������ƽ����
            if(V_Trigg[_Trigg[SOURCE].Value].Value < MAX_Y-4) 
              V_Trigg[_Trigg[SOURCE].Value].Value++;
          } else if((Current == BK_LIGHT)||(Current == VOLUME)){// �������������
            if(_Curr[1].Value < _Curr[1].Limit)   _Curr[1].Value++;
          } else if((Current == T_BASE)&&(_Det == XPOSI)){      // X_POSI����
            if(_Curr[_Det].Value <(_Curr[_Det].Limit-30))  _Curr[_Det].Value += 30; 
            else if(_Curr[_Det].Value < _Curr[_Det].Limit) _Curr[_Det].Value ++;
            _X_View.Flag |= UPDAT;                      
          } else {                                              // ��ǰ��Ϊ����
            if(_Curr[_Det].Value < _Curr[_Det].Limit)  _Curr[_Det].Value++;
            else if(_Curr[_Det].MARK & CIRC)   _Curr[_Det].Value  = 0;
          }
          if((Current == T_BASE)&&(_Det == MODE)){     // T_BASE MODE ѡ��
            Title[RUNNING][STATE].Value = RUN;         // STATE = RUNNING 
            Title[RUNNING][STATE].Flag |= UPDAT;       // ˢ�� RUNNING STATE
          }
          if((Current == OUTPUT)&&(Title[OUTPUT][SOURCE].Value != DIGI)){
            if(Title[OUTPUT][FRQN].Value > 10) 
              Title[OUTPUT][FRQN].Value = 10;          // ģ���ź�Ƶ������Ϊ20KHz
          }
          if((Current == FILE)&&(_Curr[0].Value == 1))  
            _Curr[2].Value = 1;                        // ֻ��Load Dat�ļ�
          _Curr[0].Flag |= UPDAT;
          _Curr[1].Flag |= UPDAT;
          _Curr[2].Flag |= UPDAT;
          _Curr[3].Flag |= UPDAT;
        } else {
          Meter[Current-METER_0].Flag |= UPDAT;
          if(Meter[Current-METER_0].Item < MIN)  
            Meter[Current-METER_0].Item += 1;          // �ı������Ŀ
          else                     
            Meter[Current-METER_0].Item  = VBT;
          if(Meter[Current-METER_0].Item == VBT) 
            Meter[Current-METER_0].Track = 4;
          if(Meter[Current-METER_0].Item == VPP) 
            Meter[Current-METER_0].Track = 0;
        }
      }
      Key_Buffer=0;
      Update = 1;
    }
  }
}
/*********************************  END OF FILE  ******************************/
