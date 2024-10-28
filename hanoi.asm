.text
	#PRACTICE
	#Luis Francisco Zarate Diaz
	#Luis Fernando Del Real Vazquez
	
	# Inicializacion de variables
	addi s0, zero, 15        # Numero de discos (modificable)
	add s9, zero, s0	# numero de discos (no modificable)
	addi t0, zero, 0        # Iterador para generar los discos
	
	# Inicializacion de punteros a las torres A, B y C
	lui a3, 0x10010         # Torre A
	addi a3, a3, 0
	lui a4, 0x10010         # Torre B
	addi a4, a4, 32         # Asumiendo que la torre B esta 0x20 bytes despues de la torre A
	lui a5, 0x10010         # Direccion de la torre C
	addi a5, a5, 64         # Asumiendo que la torre C esta 0x30 bytes despues de la torre A
	
	add t6, zero, a3
	add t0,zero,s0
	for:
		sw t0, 0(t6)
		addi t0, t0, -1
		addi t6, t6, 4
		
		bnez t0, for
	
	# Llamada inicial a la funcion recursiva para resolver las Torres de Hanoi
	jal hanoi
	
	#Acaba el codigo
	jal endcode
	
	hanoi:
		addi t1, zero, 1
		bne s0, t1, recursividad
		
		#OFFSET TORRE A (a3)
		sub t2,s9,s0 #s9-s0
		slli s2,t2,2 #guardamos en s2 el resultado de 4*(s7-s0)
		add s3,a3,s2 #guardamos en s3 el resultado final de s3 + 4*(s7-s0)
		    
		#OFFSET TORRE C (a5)
		sub t4,s9,s0  #s9-s0
		slli s5,t4,2 #guardamos en s2 el resultado de 4*(s7-s0)
		add s6,a5,s5 #guardamos en s3 el resultado final de s3 + 4*(s7-s0)
		    
		#movemos los discos con sus respectivos offsets (de a3 a a5)
		lw s4,0(s3) #sacamos el disco de la torre A con su respectivo offset y lo guardamos en s4
		sw zero,0(s3) #escribimos 0 en la posicion del disco que recien sacamos para leer
		sw s4,0(s6) #guardamos el valor de a4 en nuestra torre 3 con su respectivo offset
		
		jalr ra
		
		recursividad:
			#push -> ra, s0
			addi sp, sp, -20
			sw ra, 4(sp)
			sw s0, 8(sp)
			sw a3, 12(sp)
			sw a4, 16(sp)
			sw a5, 20(sp)
			# mod args -> -1
			addi s0, s0, -1
			
			add t3, a4, zero
			
			add a4,a5,zero # a4=a5
    			add a5,t3,zero # s5=t3(a4)
			jal hanoi
			#pop <-
			lw a5, 20(sp)
			lw a4, 16(sp)
			lw a3, 12(sp)
			lw s0, 8(sp)
			lw ra, 4(sp)
			addi sp, sp, 20
			
			#OFFSET DE NUESTRA TORRE 1 (a3)
			sub t2,s9,s0 #s9-s0
			slli s2,t2,2 #guardamos en s2 el resultado de 4*(s7-s0)
			add s3,a3,s2 #guardamos en s3 el resultado final de s3 + 4*(s7-s0)
			    
			#OFFSET DE NUESTRA TORRE 2(aS)
			sub t4,s9,s0  #s9-s0
			slli s5,t4,2 #guardamos en s2 el resultado de 4*(s7-s0)
			add s6,a5,s5 #guardamos en s3 el resultado final de s3 + 4*(s7-s0)
			    
			#movemos los discos con sus respectivos offsets (de a3 a a5)
			lw s4,0(s3) #sacamos el disco de la torre 1 con su respectivo offset y lo guardamos en s4
			sw zero,0(s3) #escribimos 0 en la posicion del disco que recien sacamos para leer
			sw s4,0(s6) #guardamos el valor de a4 en nuestra torre 3 con su respectivo offset
    
					
			#push -> ra, s0
			addi sp, sp, -20
			sw ra, 4(sp)
			sw s0, 8(sp)
			sw a3, 12(sp)
			sw a4, 16(sp)
			sw a5, 20(sp)
			# mod args -> -1
			addi s0, s0, -1
			
			add t3, a3, zero
			
			add a3,a4,zero # a3=a4
    			add a4,t3,zero # s5=t3(a3)
    			
			jal hanoi
			#pop <-
			lw a5, 20(sp)
			lw a4, 16(sp)
			lw a3, 12(sp)
			lw s0, 8(sp)
			lw ra, 4(sp)
			addi sp, sp, 20
			
			jalr ra
	endcode: nop
	
		
	
	
	
