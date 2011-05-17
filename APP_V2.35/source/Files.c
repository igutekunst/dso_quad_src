/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : file.c  
 Version   : DS203_APP Ver 2.3x                                  Author : bure
*******************************************************************************/
#include <string.h>
#include "Interrupt.h"
#include "Function.h"
#include "Process.h"
#include "BIOS.h"
#include "File.h"
#include "Draw.h"
#include "Menu.h"

/*******************************************************************************

U�̵����������ݣ�0x00      ���Ϊ 0xEB �� 0xE9 ���ʾ������ͬʱҲ���߼�����������
                 0x01C6~0x01C9 4�ֽ�Ϊ�߼�������ʼλ�ã���λ�ں�  DiskStart    

�������������ݣ�0x000B,0x000C 2�ֽڸ��������ֽڳ��ȣ���λ�ں�    SectorsLen   
                       0x000D 1�ֽڸ���ÿ�ص���������2���������ݣ� SecPerClus   
                0x000E,0x000F 2�ֽڸ��̵ı�������������λ�ں�    RsvdSecCnt    
��FAT16��       0x0016,0x0017 2�ֽ� FATռ�õ�����������λ�ں�    FAT_Size16   FAT32ʱ��ֵΪ 0x0000
                0x001C~0x001F 4�ֽڸ��̵���������������λ�ں�    Hidden_Sec    
��FAT32��       0x0024,0x0025 2�ֽ� FATռ�õ�����������λ�ں�    FAT_Size32   

FAT��ĳ���   ��FAT_LEN   = FAT_Size16 ��SectorsLen           
FAT1��ʼ����  ��FAT1_Sect = DiskStart + RsvdSecCnt           
FAT2��ʼ����  ��FAT2_Sect = FAT1_Sect + FAT_Size16           
��Ŀ¼��ʼ������Root_Sect = FAT2_Sect + FAT_Size16           
��Ŀ¼��ʼ��ַ��Root_Addr = Root_Sect ��SectorsLen   

��Ŀ¼�������ݣ�Root_Addr + 0x0020 ��ʼ��ÿ��Ŀ¼���Ϊ 0x20��
                FAT16��Ŀ¼ռ�������� SecPerRoot = 0x20 
                FAT32��Ŀ¼ռ�������� SecPerRoot = 0x01 �� SecPerClus 

Ŀ¼���е����ݣ�0x00~0x07 8�ֽ��ļ���   
                0x08~0x0A 3�ֽ���չ��
                0x16,0x17 2�ֽ�����޸�ʱ�䣨 = Hour << 11 + Minute << 5 + Second >> 1 ��
                0x18,0x19 2�ֽ�����޸����ڣ� =�� Year - 1980 ��<< 9 + Month << 5 + Day ��
��FAT32��       0x14,0x15 �ļ���ʼ�غ�Bit 16~31����λ�ֽ��ں�Cluster_Hi
��FAT16��       0x1A,0x1B �ļ���ʼ�غ�Bit  0~15����λ�ֽ��ں�Cluster     0x12E5
                0x1C-0x1F 4�ֽڵ��ļ��ֽڳ��� ����λ�ں�
                  
�ļ���ʼ��ַ  ��File_Addr =�� Root_Sect + SecPerRoot +��Cluster -0x02����SecPerClus ����Sectors_LEN

*******************************************************************************/
u32 DiskStart, Hidden_Sec, Root_Addr, ClusterNum, File_Addr, File_Size; 
u16 RsvdSecCnt, SectorSize, FAT_Size16, FAT_Size32; 
u16 SecPerClus, /*DirFliePtr, DirFlieSec, */DirSecNum, MaxNum;
u8  SecBuff[512];
u8  FileBuff[1200];
u32 Offset, Count;
u16 BMP_Color[16] = { WHT,  CYAN,  CYAN_,  YEL,   
                      YEL_, PURPL, PURPL_, GRN,    
                      GRN_, GRAY,  ORANGE, BLUE,    
                      RED,  BLACK, BLACK,  BLACK,}; 

  
#define WHT        0xFFFF
#define CYAN       0xFFE0
#define CYAN_      0xBDE0
#define YEL        0x07FF
#define YEL_       0x05F7
#define PURPL      0xF81F
#define PURPL_     0xB817
#define GRN        0x07E0
#define GRN_       0x05E0
#define GRAY       0x7BEF   
#define ORANGE     0x051F
#define BLUE       0xF800
#define RED        0x001F
#define BLACK      0x0000

/*******************************************************************************
 ��ָ����չ�����ļ�            ���룺�ļ���չ��             ����ֵ��0x00=�ɹ� 
*******************************************************************************/
u8 Open_File(u8 FileNum, u8 *ExtName)
{
  u8 i, j, k; 
  u16 SectorCnt;
  u8 FileName[12]="FILE    BMP", Num[4];
  
               // ------------�����ļ���------------ //      
  u8ToDec3(Num, FileNum);
  FileName[4] = Num[0];
  FileName[5] = Num[1];
  FileName[6] = Num[2];
  FileName[8] = ExtName[0];
  FileName[9] = ExtName[1];
  FileName[10]= ExtName[2];
  
               // ------------��ȡU�̲���----------- //      
  DiskStart =0;
  DirSecNum = 0x20;             
  __Disk_Buff_RD(SecBuff, 0, 256);
  SectorSize =(SecBuff[0x0C]<<8)+(SecBuff[0x0B]);     // 0200
  SecPerClus = SecBuff[0x0D];                            // 01
  RsvdSecCnt =(SecBuff[0x0F]<<8)+(SecBuff[0x0E]);     // 0008
  FAT_Size16 =(SecBuff[0x17]<<8)+(SecBuff[0x16]);     // 000C
  Hidden_Sec =(SecBuff[0x1F]<<24)+(SecBuff[0x1E]<<16)
    +(SecBuff[0x1D]<<8)+(SecBuff[0x1C]);              // 0000

               // ------------��ȡ��Ŀ¼----------- //      
  Root_Addr =(DiskStart + RsvdSecCnt + 2*FAT_Size16)*SectorSize; // 4000 
  __Disk_Buff_RD(SecBuff, Root_Addr, 512);

               // ------------�����ļ���----------- //      
  for(SectorCnt =0; SectorCnt < DirSecNum; SectorCnt++){
    __Disk_Buff_RD(SecBuff, Root_Addr + SectorCnt*512, 512);
    for(i=0; i<16; i++){
      if(SecBuff[i*32] == 0xE5)  k = 0xFF;  // ��ɾ�����ļ���
      else                       k = 0;     // �������ļ���
      for(j=0; j<11; j++){
        if(SecBuff[i*32+j] != FileName[j])  k |= 0xFF; // 
      }
      if(k == 0) {                              // File is found
        
               // ------�����ļ���С����ŵ�ַ----- //      
        ClusterNum =((SecBuff[i*32+0x1B]<<8)+(SecBuff[i*32+0x1A])); // 00E5
        File_Addr  = Root_Addr +(DirSecNum +(ClusterNum -2)*SecPerClus)*512;// 4000+(20+(E5-2))*200
        File_Size  =((SecBuff[i*32+0x1C])+(SecBuff[i*32+0x1D]<<8)+
                    (SecBuff[i*32+0x1E]<<16)+(SecBuff[i*32+0x1F]<<24));
        return 0;
      }
    }
  }
  return 0xFF;
}
/*******************************************************************************
Save_Dat: ���浱ǰ��Ļ��ʾͼ��ԭʼ����    ���룺�ļ����     ����ֵ��0x00=�ɹ� 
*******************************************************************************/
u8 Save_Dat(u8 FileNum)
{
  u16 i, j, Rvalue; 
  
  Rvalue = Open_File(FileNum, "DAT");  // 2 KB data lenght : 4 *300 = 1.2KBytes
  if(Rvalue != 0) return Rvalue;
  
  for(j=0; j<4; j++){
    for(i=0; i<299; i++){
      SecBuff[i] = TrackBuff[i*4 + j];
    }
    SecBuff[299] = Title[j][POSI].Value;
    __Disk_Buff_WR(SecBuff, File_Addr + j*512);
    __Disk_Buff_WR(SecBuff + 256, File_Addr + 256 +j*512);
  }
  
  return 0;
}
/*******************************************************************************
Load_Dat: ���ر��������Ļͼ��ԭʼ����    ���룺�ļ����     ����ֵ��0x00=�ɹ� 
*******************************************************************************/
u8 Load_Dat(u8 FileNum)
{
  u16  Rvalue;

  Rvalue = Open_File(FileNum, "DAT");  // 2 KB data lenght : 4 *300 = 1.2KBytes
  if(Rvalue != 0) return Rvalue;
  
  __Disk_Buff_RD(FileBuff,         File_Addr,     300);
  
  __Disk_Buff_RD(FileBuff+300,     File_Addr+2*256, 300);

  __Disk_Buff_RD(FileBuff+600,     File_Addr+4*256, 300);

  __Disk_Buff_RD(FileBuff+900,     File_Addr+6*256, 300);
  
  return 0;
}
/*******************************************************************************
Save_Bmp: ���浱ǰ��Ļ��ʾͼ��ΪBMP��ʽ    ���룺�ļ����     ����ֵ��0x00=�ɹ� 
*******************************************************************************/
u8 Save_Bmp(u8 FileNum)
{
  u16  x=0, y=0, ColorH, ColorL, Rvalue;
  u8   i, j, k; 

  Rvalue = Open_File(FileNum, "BMP");  // 47 KB data lenght = 256*188 = 48128 Bytes
  if(Rvalue != 0) return Rvalue;
  __Disk_Buff_RD(SecBuff, File_Addr, 256);
  
  i = 0x0036; // ��ɫ���ſ�ʼ��ַ
  for(j=0; j<16; ++j){
    SecBuff[j*4 +i+0]=(BMP_Color[j]& 0xF800)>>8; // Bule
    SecBuff[j*4 +i+1]=(BMP_Color[j]& 0x07E0)>>3; // Green
    SecBuff[j*4 +i+2]=(BMP_Color[j]& 0x001F)<<3; // Red
    SecBuff[j*4 +i+3]= 0;                        // Alpha
  }
  i = 0x0076; // ͼ�����ݿ�ʼ��ŵ�ַ
  k = 0;
  for(y=0; y<240; y++){
    for(x=0; x<400 ; x+=2){  
      __Point_SCR(x, y);
      ColorH =__LCD_GetPixl();
      __Point_SCR(x+1, y);
      ColorL =__LCD_GetPixl();
      SecBuff[i] =(Color_Num(ColorH)<<4)+ Color_Num(ColorL);
      i++;
      if(i==0){
        __Disk_Buff_WR(SecBuff, File_Addr +(k <<8));
        Print_Clk(254, 0, (SCRN<<8)+ TEXT1, (k >>2)& 3);    // ����ָʾ
        k++;
      }
    }
  }
  __Disk_Buff_WR(SecBuff, File_Addr +(k <<8));
  return 0;
}
u8 Color_Num(u16 Color)
{
  if(Color == WHT)                   return 0;
  else if((Color & CYAN  )== CYAN  ) return 1;
  else if((Color & YEL   )== YEL   ) return 3;
  else if((Color & PURPL )== PURPL ) return 5;
  else if((Color & GRN   )== GRN   ) return 7;
  else if((Color & CYAN_ )== CYAN_ ) return 2;
  else if((Color & YEL_  )== YEL_  ) return 4;
  else if((Color & PURPL_)== PURPL_) return 6;
  else if((Color & GRN_  )== GRN_  ) return 8;
  else if((Color & GRAY  )== GRAY  ) return 9;
  else if((Color & ORANGE)== ORANGE) return 10;
  else if((Color & BLUE  )== BLUE  ) return 11;
  else if((Color & RED   )== RED   ) return 12;
  else                               return 13;
}
/*******************************************************************************
Load_Parameter: ����֮ǰ�Ĺ�������                           Return: 0= Success
*******************************************************************************/
u8 Load_Parameter(void)            // ����������4ҳ��ÿҳ 256 Byte
{ 
  u8 Versions =0x03, Sum =0;
  u16 i;
  u16* p = (u16*)SecBuff;
  
  __Param_Area_RD(SecBuff, PAGE_0);
 
  if(Versions !=(*p & 0xFF)) return 1;          // �汾������
  for(i=0; i<256; ++i) Sum += SecBuff[i];
  if(Sum != 0) return 2;                  // У��ͳ�����
  
  Current =(*p++ >>8);                    // ����֮ǰ�� Current Title
  
  for(i=0; i<7; i++){ 
    Detail[i*2]  = *p;
    Detail[i*2+1]= (*p++ >>8);             // ����֮ǰ�� Detail
  }
  for(i=0; i<13; i++){
    Title[i][0].Value = *p++;             // ����֮ǰ����ʾ�˵��и�����Ӧ���ֵ
    Title[i][1].Value = *p++;
    Title[i][2].Value = *p++;
    Title[i][3].Value = *p++;
  }
  for(i=0; i<9; i++){
    Meter[i].Item     = *p;
    Meter[i].Track    =(*p++ >>8);        // ����֮ǰ�Ĳ�����Ŀ����������
  }
  for(i=0; i<10; i++){
    Ka1[i] = *p;                         // �ָ�ԭ���� A ͨ��������У��ϵ��
    Kb1[i] =(*p++ >>8);                  // �ָ�ԭ���� B ͨ��������У��ϵ��
    Ka2[i] = *p++;                       // �ָ�ԭ���� A ͨ���������У��ϵ��
    Kb2[i] = *p++;                       // ����֮ǰ�� B ͨ���������У��ϵ��
  }
  Ka3 = *p++;                            // �ָ�ԭ���� A ͨ��λ�����У��ϵ��
  Kb3 = *p++;                            // �ָ�ԭ���� B ͨ��λ�����У��ϵ��

  V_Trigg[A].Value = *p++;
  V_Trigg[B].Value = *p++;               // �ָ�ԭ��A,Bͨ��������ֵ
  
  return 0;
}
/*******************************************************************************
 Save_Parameter: ���浱ǰ�Ĺ�������                          Return: 0= Success
*******************************************************************************/
u8 Save_Parameter(u8 Default)             // ����������4ҳ��ÿҳ 256 Byte
{                                          // Ŀǰֻ���˵�0ҳ
  u8 Versions =0x03, Sum =0;
  u16* p =(u16*)SecBuff;
  u16  i;
  
  memset(SecBuff,0,256);  
  
  if(Default) Versions =0xFF;
  *p++ =(Current <<8)+ Versions;            // ��������汾�ż���ǰ�� Title
  
  for(i=0; i<7; i++) 
    *p++ =(Detail[i*2+1]<<8)+ Detail[i*2]; // ���浱ǰ�� Detail
  
  for(i=0; i<13; i++){                     // ������ʾ�˵��и�����Ӧ���ֵ
    *p++ = Title[i][0].Value;
    *p++ = Title[i][1].Value;
    *p++ = Title[i][2].Value;
    *p++ = Title[i][3].Value;
  }
  for(i=0; i<9; i++){
    *p++ =(Meter[i].Track<<8)+ Meter[i].Item; // ���������Ŀ����������
  }
  for(i=0; i<10; i++){
    *p++ =(Kb1[i]<<8)+ Ka1[i];             // ���浱ǰ A,B ͨ��������У��ϵ��
    *p++ = Ka2[i];                         // ���浱ǰ A ͨ���������У��ϵ��
    *p++ = Kb2[i];                         // ���浱ǰ B ͨ���������У��ϵ��
  }
  *p++ = Ka3;                              // ���浱ǰ A ͨ��λ�����У��ϵ��
  *p++ = Kb3;                              // ���浱ǰ B ͨ��λ�����У��ϵ��
  
  *p++ = V_Trigg[A].Value;
  *p++ = V_Trigg[B].Value;                 // ���浱ǰA,Bͨ��������ֵ   
  
  for(i=0; i<255; i++)  Sum += SecBuff[i]; //���������У���
  SecBuff[255] = (~Sum)+ 1;
  __Param_Area_WR(SecBuff, PAGE_0); 
  return 0;
}

/******************************** END OF FILE *********************************/

