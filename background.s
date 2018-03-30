.equ ADDR_VGA, 0x08000000

.align 2
# essentially behaves as though you had .byte .... [many many bytes declared]...
BACKGROUND:
    .incbin "background.bmp"
    
    movia r2,ADDR_VGA
    
    movui r4,0xffff  /* White pixel */
    sthio r4,1032(r2) /* pixel (4,1) is x*2 + y*1024 so (8 + 1024 = 1032) */
