.data  
num0: .word 1 
num1: .word 10

.text 
main:
   #inicializa constantes
  and $a0, $zero, $zero  #  a0 = 0
  and $a1, $zero, $zero  #  a1 = 0
  lw $t0, 0($zero)   	# t0 = 1 
  lw $t1, 4($zero)   	# t1 = 10
  nop
  
  #loop infinito
  loop: 
  	add $a0,  $a0, $t0 # a0++
  	nop
  	nop
  	slt $t2, $a0, $t1 
  	nop
  	nop
  	beq $t2, $t0, no_correction
  	add $t3, $t0, $t3 # modificación realizada para ver la cantidad de iteraciones, iría un nop acá.
  	nop
  	nop
  	jal decimal_correction
  	nop
  	nop
  	
  	no_correction:
  	beq $t0, $t0, loop
  	nop
  	nop
  	nop
  
  # correccion de unidades  
  decimal_correction: 
 	and $a0, $zero, $zero  #  a0 = 0
  	add $a1, $a1, $t0  #  a1++
  	jr $ra
  	nop
  	
  	
    
  	
  

