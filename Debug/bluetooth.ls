   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
 113                     ; 41 void vHandle_BT_Add_Device_Flow(void)
 113                     ; 42 {
 115                     	switch	.text
 116  0000               _vHandle_BT_Add_Device_Flow:
 118  0000 5205          	subw	sp,#5
 119       00000005      OFST:	set	5
 122                     ; 43     uint8_t i = 0, j = 0;
 126                     ; 45     bool myInterruptFlag = FALSE;
 128                     ; 49     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 130  0002 4b00          	push	#0
 131  0004 ae0255        	ldw	x,#597
 132  0007 cd0000        	call	_UART1_ITConfig
 134  000a 84            	pop	a
 135                     ; 50     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 137  000b 4b00          	push	#0
 138  000d ae0244        	ldw	x,#580
 139  0010 cd0000        	call	_UART1_ITConfig
 141  0013 84            	pop	a
 142                     ; 51     myInterruptFlag = TRUE;
 144  0014 a601          	ld	a,#1
 145  0016 6b02          	ld	(OFST-3,sp),a
 147                     ; 54     if (strstr(response_buffer, "+BTCONNECTING:") && strstr(response_buffer, "SPP"))
 149  0018 ae0024        	ldw	x,#L55
 150  001b 89            	pushw	x
 151  001c ae0000        	ldw	x,#_response_buffer
 152  001f cd0000        	call	_strstr
 154  0022 5b02          	addw	sp,#2
 155  0024 a30000        	cpw	x,#0
 156  0027 2758          	jreq	L35
 158  0029 ae0020        	ldw	x,#L75
 159  002c 89            	pushw	x
 160  002d ae0000        	ldw	x,#_response_buffer
 161  0030 cd0000        	call	_strstr
 163  0033 5b02          	addw	sp,#2
 164  0035 a30000        	cpw	x,#0
 165  0038 2747          	jreq	L35
 166                     ; 56         delay_ms(100);
 168  003a ae0064        	ldw	x,#100
 169  003d cd0000        	call	_delay_ms
 171                     ; 57         ms_send_cmd(BT_ACCEPT_SPP_REQ, strlen((const char *)BT_ACCEPT_SPP_REQ));
 173  0040 4b0b          	push	#11
 174  0042 ae0014        	ldw	x,#L16
 175  0045 cd0000        	call	_ms_send_cmd
 177  0048 84            	pop	a
 178                     ; 59         timeout = 0;
 180  0049 5f            	clrw	x
 181  004a 1f03          	ldw	(OFST-2,sp),x
 183                     ; 60         for (i = 0; i < 99; i++)
 185  004c 0f05          	clr	(OFST+0,sp)
 187  004e               L37:
 188                     ; 62             while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
 190  004e ae0020        	ldw	x,#32
 191  0051 cd0000        	call	_UART1_GetFlagStatus
 193  0054 4d            	tnz	a
 194  0055 260c          	jrne	L77
 196  0057 1e03          	ldw	x,(OFST-2,sp)
 197  0059 1c0001        	addw	x,#1
 198  005c 1f03          	ldw	(OFST-2,sp),x
 200  005e a32710        	cpw	x,#10000
 201  0061 26eb          	jrne	L37
 202  0063               L77:
 203                     ; 64             response_buffer[i] = UART1_ReceiveData8();
 205  0063 7b05          	ld	a,(OFST+0,sp)
 206  0065 5f            	clrw	x
 207  0066 97            	ld	xl,a
 208  0067 89            	pushw	x
 209  0068 cd0000        	call	_UART1_ReceiveData8
 211  006b 85            	popw	x
 212  006c e700          	ld	(_response_buffer,x),a
 213                     ; 65             timeout = 0;
 215  006e 5f            	clrw	x
 216  006f 1f03          	ldw	(OFST-2,sp),x
 218                     ; 60         for (i = 0; i < 99; i++)
 220  0071 0c05          	inc	(OFST+0,sp)
 224  0073 7b05          	ld	a,(OFST+0,sp)
 225  0075 a163          	cp	a,#99
 226  0077 25d5          	jrult	L37
 227                     ; 67         response_buffer[i] = '\0';
 229  0079 7b05          	ld	a,(OFST+0,sp)
 230  007b 5f            	clrw	x
 231  007c 97            	ld	xl,a
 232  007d 6f00          	clr	(_response_buffer,x)
 234  007f 203e          	jra	L101
 235  0081               L35:
 236                     ; 70     else if (strstr(response_buffer, "KEY") && strstr(response_buffer, PASS_KEY))
 238  0081 ae0010        	ldw	x,#L501
 239  0084 89            	pushw	x
 240  0085 ae0000        	ldw	x,#_response_buffer
 241  0088 cd0000        	call	_strstr
 243  008b 5b02          	addw	sp,#2
 244  008d a30000        	cpw	x,#0
 245  0090 272d          	jreq	L101
 247  0092 ae0000        	ldw	x,#_PASS_KEY
 248  0095 89            	pushw	x
 249  0096 ae0000        	ldw	x,#_response_buffer
 250  0099 cd0000        	call	_strstr
 252  009c 5b02          	addw	sp,#2
 253  009e a30000        	cpw	x,#0
 254  00a1 271c          	jreq	L101
 255                     ; 73         delay_ms(100);
 257  00a3 ae0064        	ldw	x,#100
 258  00a6 cd0000        	call	_delay_ms
 260                     ; 74         vSend_Data_Over_SPP(aunIMEI, strlen((const char *)aunIMEI), TRUE);
 262  00a9 4b01          	push	#1
 263  00ab ae0000        	ldw	x,#_aunIMEI
 264  00ae cd0000        	call	_strlen
 266  00b1 9f            	ld	a,xl
 267  00b2 88            	push	a
 268  00b3 ae0000        	ldw	x,#_aunIMEI
 269  00b6 ad20          	call	_vSend_Data_Over_SPP
 271  00b8 85            	popw	x
 272                     ; 75         delay_ms(200);
 274  00b9 ae00c8        	ldw	x,#200
 275  00bc cd0000        	call	_delay_ms
 277  00bf               L101:
 278                     ; 78     if (myInterruptFlag) // Handle UART RX Interrupt enable/disable
 280  00bf 0d02          	tnz	(OFST-3,sp)
 281  00c1 2712          	jreq	L701
 282                     ; 80         UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 284  00c3 4b01          	push	#1
 285  00c5 ae0255        	ldw	x,#597
 286  00c8 cd0000        	call	_UART1_ITConfig
 288  00cb 84            	pop	a
 289                     ; 81         UART1_ITConfig(UART1_IT_IDLE, ENABLE);
 291  00cc 4b01          	push	#1
 292  00ce ae0244        	ldw	x,#580
 293  00d1 cd0000        	call	_UART1_ITConfig
 295  00d4 84            	pop	a
 296                     ; 82         myInterruptFlag = FALSE;
 298  00d5               L701:
 299                     ; 84 }
 302  00d5 5b05          	addw	sp,#5
 303  00d7 81            	ret
 306                     .const:	section	.text
 307  0000               L111_temp:
 308  0000 41542b425453  	dc.b	"AT+BTSPPSEND=12",0
 374                     ; 86 void vSend_Data_Over_SPP(char *ptr, uint8_t unLength, bool bAddSpecialChar)
 374                     ; 87 {
 375                     	switch	.text
 376  00d8               _vSend_Data_Over_SPP:
 378  00d8 89            	pushw	x
 379  00d9 5210          	subw	sp,#16
 380       00000010      OFST:	set	16
 383                     ; 88     uint8_t temp[16] = "AT+BTSPPSEND=12";
 385  00db 96            	ldw	x,sp
 386  00dc 1c0001        	addw	x,#OFST-15
 387  00df 90ae0000      	ldw	y,#L111_temp
 388  00e3 a610          	ld	a,#16
 389  00e5 cd0000        	call	c_xymvx
 391                     ; 91     if (bAddSpecialChar)
 393  00e8 0d16          	tnz	(OFST+6,sp)
 394  00ea 2702          	jreq	L541
 395                     ; 92         unLength++;
 397  00ec 0c15          	inc	(OFST+5,sp)
 398  00ee               L541:
 399                     ; 93     if (unLength < 10)
 401  00ee 7b15          	ld	a,(OFST+5,sp)
 402  00f0 a10a          	cp	a,#10
 403  00f2 2414          	jruge	L741
 404                     ; 95         temp[13] = (unLength % 10) | 0x30;
 406  00f4 7b15          	ld	a,(OFST+5,sp)
 407  00f6 5f            	clrw	x
 408  00f7 97            	ld	xl,a
 409  00f8 a60a          	ld	a,#10
 410  00fa 62            	div	x,a
 411  00fb 5f            	clrw	x
 412  00fc 97            	ld	xl,a
 413  00fd 9f            	ld	a,xl
 414  00fe aa30          	or	a,#48
 415  0100 6b0e          	ld	(OFST-2,sp),a
 417                     ; 96         temp[14] = '\0';
 419  0102 0f0f          	clr	(OFST-1,sp)
 421                     ; 97         temp[15] = '\0';
 423  0104 0f10          	clr	(OFST+0,sp)
 426  0106 2022          	jra	L151
 427  0108               L741:
 428                     ; 99     else if (unLength < 100)
 430  0108 7b15          	ld	a,(OFST+5,sp)
 431  010a a164          	cp	a,#100
 432  010c 241c          	jruge	L151
 433                     ; 101         temp[13] = (unLength / 10) | 0x30;
 435  010e 7b15          	ld	a,(OFST+5,sp)
 436  0110 5f            	clrw	x
 437  0111 97            	ld	xl,a
 438  0112 a60a          	ld	a,#10
 439  0114 62            	div	x,a
 440  0115 9f            	ld	a,xl
 441  0116 aa30          	or	a,#48
 442  0118 6b0e          	ld	(OFST-2,sp),a
 444                     ; 102         temp[14] = (unLength % 10) | 0x30;
 446  011a 7b15          	ld	a,(OFST+5,sp)
 447  011c 5f            	clrw	x
 448  011d 97            	ld	xl,a
 449  011e a60a          	ld	a,#10
 450  0120 62            	div	x,a
 451  0121 5f            	clrw	x
 452  0122 97            	ld	xl,a
 453  0123 9f            	ld	a,xl
 454  0124 aa30          	or	a,#48
 455  0126 6b0f          	ld	(OFST-1,sp),a
 457                     ; 103         temp[15] = '\0';
 459  0128 0f10          	clr	(OFST+0,sp)
 461  012a               L151:
 462                     ; 105     ms_send_cmd(temp, strlen((const char *)temp));
 464  012a 96            	ldw	x,sp
 465  012b 1c0001        	addw	x,#OFST-15
 466  012e cd0000        	call	_strlen
 468  0131 9f            	ld	a,xl
 469  0132 88            	push	a
 470  0133 96            	ldw	x,sp
 471  0134 1c0002        	addw	x,#OFST-14
 472  0137 cd0000        	call	_ms_send_cmd
 474  013a 84            	pop	a
 475                     ; 106     if (bAddSpecialChar)
 477  013b 0d16          	tnz	(OFST+6,sp)
 478  013d 2702          	jreq	L551
 479                     ; 107         unLength--;
 481  013f 0a15          	dec	(OFST+5,sp)
 482  0141               L551:
 483                     ; 108     delay_ms(1000);
 485  0141 ae03e8        	ldw	x,#1000
 486  0144 cd0000        	call	_delay_ms
 488                     ; 109     ms_send_cmd(ptr, unLength);
 490  0147 7b15          	ld	a,(OFST+5,sp)
 491  0149 88            	push	a
 492  014a 1e12          	ldw	x,(OFST+2,sp)
 493  014c cd0000        	call	_ms_send_cmd
 495  014f 84            	pop	a
 496                     ; 110     delay_ms(1000);
 498  0150 ae03e8        	ldw	x,#1000
 499  0153 cd0000        	call	_delay_ms
 501                     ; 112 }
 504  0156 5b12          	addw	sp,#18
 505  0158 81            	ret
 518                     	xref.b	_response_buffer
 519                     	xref.b	_PASS_KEY
 520                     	xref.b	_aunIMEI
 521                     	xdef	_vSend_Data_Over_SPP
 522                     	xdef	_vHandle_BT_Add_Device_Flow
 523                     	xref	_ms_send_cmd
 524                     	xref	_delay_ms
 525                     	xref	_UART1_GetFlagStatus
 526                     	xref	_UART1_ReceiveData8
 527                     	xref	_UART1_ITConfig
 528                     	xref	_strlen
 529                     	xref	_strstr
 530                     	switch	.const
 531  0010               L501:
 532  0010 4b455900      	dc.b	"KEY",0
 533  0014               L16:
 534  0014 41542b425441  	dc.b	"AT+BTACPT=1",0
 535  0020               L75:
 536  0020 53505000      	dc.b	"SPP",0
 537  0024               L55:
 538  0024 2b4254434f4e  	dc.b	"+BTCONNECTING:",0
 539                     	xref.b	c_x
 559                     	xref	c_xymvx
 560                     	end
