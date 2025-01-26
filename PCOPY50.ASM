; 50 lines text mode PCOPY substitute for QBasic.
push bp           ; Save previous bp.
mov bp,sp         ; Set new bp.
push ds           ; Save ds.
push es           ; Save es.
push di           ; Save di.
push si           ; Save si.

mov cx,0xb800     ; Set bx to the first screen page's segment address.
mov dx,0xba04     ; Set cx to the second screen page's segment address.
mov bx,[bp+6]     ; Load parameter. (0 = copy, 1 = restore)
cmp word [bx],0   ; Unless parameter is zero, these addresses are swapped before copying.
je SkipSwap       ;
 xchg cx,dx       ;
SkipSwap:         ;

mov ds,cx         ; Load source segment address.
mov es,dx         ; Load target segment address.
xor di,di         ; Set di to zero.
xor si,si         ; Set si to zero.
mov cx,4000       ; Set the number of words to be copied.
rep movsw         ; Copy the source screen page to the target page.

pop si            ; Restore si.
pop di            ; Restore di.
pop es            ; Restore es.
pop ds            ; Restore ds.
pop bp            ; Restore bp.
retf 2            ; Return and remove arguments from stack.
