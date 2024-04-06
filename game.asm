#####################################################################
#
# CSCB58 Winter 2024 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Mealad Ebadi, 1009137248, ebadimea, mealad.ebadi@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8 (update this as needed)
# - Unit height in pixels: 8 (update this as needed)
# - Display width in pixels: 512 (update this as needed)
# - Display height in pixels: 512 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1 & 2 & 3 & 4
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. Shoot enemies (1 enemy)
# 2. Moving platforms (2 platforms)
# 3. Moving enemies (2 enemies)
# 4. Pickup Effects (1 Pickup)
# 5. Start Menu
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# To turn off collisions to make it easier to test for winning:
# Go to line 798 and change collision to drawRest
# Go to line 805 and write j drawRest
# Movement is: W to jump, A - left,  D - right, S - shoot (max 5 shots at a time)
#####################################################################

.eqv BASE_ADDRESS 0x10008000
.eqv RED 0xff0000
.eqv GREEN 0x00ff00
.eqv WHITE 0xFFFFFFFF
.eqv MIX 0xFF00FF
.eqv BLUE 0x0000ff
.eqv MIX1 0xffff00
.eqv BACKGROUND 0xfff7f7fa
.data
baseAddress: .word BASE_ADDRESS #Store base address
character_base: .word 14340
character_x: .word 2
character_y: .word 55
new_character: .word 14340
enemy_base: .word 14584
enemy_x: .word 63
enemy_new: .word 14584
enemyDir: .word 0
enemy_base2: .word 11512
enemy_new2: .word 11512
heart: .word 12848
platform_x: .word 1
platformDir: .word 1
platform_new: .word 13608, 12072
standPlatform: .word 0
numBlocks: .word 0
numBlocksDestroyed: .word 0
score: .word 0
lives: .word 0
lifeLocation: .word 0, 0, 0
platform_base_location: .word 13096, 13288, 13608, 12072
shot_x: .word 0, 0, 0, 0, 0
shot_y: .word 0, 0, 0, 0, 0

.text
main: 
	startOfGame: 
		jal clearScreen
		jal start
		jal quit
		j signal
	

clearScreen:
    # Load the base address into register $t2
    li $t1, BASE_ADDRESS
    
    # Calculate the total number of pixels on the screen (256 * 256 = 65536 pixels)
    li $t2, 65536
    clear_loop:
    	# Write the color for black (assume black is represented by 0x00000000) to the current pixel
    	sw $zero, 0($t1)  # Store a word of 0 (black) at the current pixel
    	
    	# Move to the next pixel (increment the address by 4 bytes)
    	addi $t1, $t1, 4
    
    	# Decrement the loop counter
    	addi $t2, $t2, -4
    
    	# Repeat the loop until all pixels are cleared
    	bnez $t2, clear_loop
    
    	# Return from the function
    	jr $ra

start: 
	# Load the base address into register $t1
    	li $t1, BASE_ADDRESS
    	li $t3, 4096
    	li $t4, 0
    li $t2, 0xfff7f7fa
    backgroundLoop:
    	move $t5, $t4
    	sll $t5, $t5, 2
    	add $t5, $t5, $t1
    	sw $t2, 0($t5)
    	addi $t4, $t4, 1
    	addi $t3, $t3, -1
    	bgtz $t3, backgroundLoop
    	
    	 # Load the ASCII values of the characters into registers
    li $t2, RED   # ASCII values for "start - s"
    
    # Write "start - s" to the screen
    #s 
    addi $t1, $t1, 2580
    sw $t2, 4($t1) 
    sw $t2, 8($t1) 
    sw $t2, 12($t1)
    sw $t2, 16($t1)  
    sw $t2, 256($t1) 
    sw $t2, 512($t1) 
    sw $t2, 772($t1) 
    sw $t2, 776($t1) 
    sw $t2, 780($t1)
    sw $t2, 1040($t1)  
    sw $t2, 1296($t1) 
    sw $t2, 1548($t1) 
    sw $t2, 1544($t1) 
    sw $t2, 1540($t1) 
    sw $t2, 1536($t1) 
   
    #t
    addi $t1, $t1, 24
    sw $t2, 264($t1) 
    sw $t2, 520($t1) 
    sw $t2, 776($t1)  
    sw $t2, 772($t1) 
    sw $t2, 780($t1) 
    sw $t2, 1032($t1) 
    sw $t2, 1288($t1) 

    #a
    	addi $t1, $t1, 24
    	sw $t2, 0($t1)
    	sw $t2, 4($t1)
    	sw $t2, 8($t1)
    	sw $t2, 12($t1)
    	sw $t2, 272($t1)
    	sw $t2, 528($t1)
    	sw $t2, 524($t1)
    	sw $t2, 520($t1)
    	sw $t2, 516($t1)
    	sw $t2, 512($t1)
    	sw $t2, 768($t1)
    	sw $t2, 1024($t1)
    	sw $t2, 1280($t1)
    	sw $t2, 1284($t1)
    	sw $t2, 1288($t1)
    	sw $t2, 1292($t1)
    	sw $t2, 1296($t1)
    	sw $t2, 1040($t1)
    	sw $t2, 784($t1)
    	
    
    
   #r
   	addi $t1, $t1, 32
   	sw $t2, 256($t1)
   	sw $t2, 512($t1)
   	sw $t2, 768($t1)
   	sw $t2, 1024($t1)
   	sw $t2, 1280($t1)
   	sw $t2, 4($t1)
   	sw $t2, 8($t1)
   	sw $t2, 12($t1)
   	sw $t2, 16($t1)
 
 #t
    addi $t1, $t1, 24
    sw $t2, 264($t1) 
    sw $t2, 520($t1) 
    sw $t2, 776($t1)  
    sw $t2, 772($t1) 
    sw $t2, 780($t1) 
    sw $t2, 1032($t1) 
    sw $t2, 1288($t1) 
    
    #-
    addi $t1, $t1, 24
    sw $t2, 768($t1) 
    sw $t2, 772($t1) 
    sw $t2, 776($t1) 
 
 #s 
    addi $t1, $t1, 24
    sw $t2, 4($t1) 
    sw $t2, 8($t1) 
    sw $t2, 12($t1)
    sw $t2, 16($t1)  
    sw $t2, 256($t1) 
    sw $t2, 512($t1) 
    sw $t2, 772($t1) 
    sw $t2, 776($t1) 
    sw $t2, 780($t1)
    sw $t2, 1040($t1)  
    sw $t2, 1296($t1) 
    sw $t2, 1548($t1) 
    sw $t2, 1544($t1) 
    sw $t2, 1540($t1) 
    sw $t2, 1536($t1)
	lw $t1, baseAddress
	jr $ra
	
quit: 
	# Load the base address into register $t2
    	li $t1, BASE_ADDRESS
    	
    	 #Load red
    li $t2, RED   
    
    # Write "quit - q" to the screen
    #q
    addi $t1, $t1, 5180
    sw $t2, 0($t1)   
    sw $t2, 4($t1) 
    sw $t2, 8($t1) 
    sw $t2, 12($t1)
    sw $t2, 16($t1)
    sw $t2, 272($t1)
    sw $t2, 528($t1)
    sw $t2, 784($t1)
    sw $t2, 1040($t1)
    sw $t2, 1296($t1)
    sw $t2, 1552($t1)
    sw $t2, 1556($t1)
    sw $t2, 1560($t1)
    sw $t2, 256($t1)  
    sw $t2, 512($t1) 
    sw $t2, 768($t1) 
    sw $t2, 1024($t1)
    sw $t2, 1028($t1)
    sw $t2, 1032($t1)
    sw $t2, 1036($t1)
    
    #u
    addi $t1, $t1, 28
    sw $t2, 0($t1)   
    sw $t2, 256($t1)   
    sw $t2, 512($t1) 
    sw $t2, 768($t1) 
    sw $t2, 1028($t1)
    sw $t2, 1032($t1) 
    sw $t2, 1036($t1) 
    sw $t2, 16($t1)   
       sw $t2, 272($t1)   
    sw $t2, 528($t1) 
    sw $t2, 784($t1) 

#i
addi $t1, $t1, 32
    sw $t2, 0($t1) 
    sw $t2, 512($t1) 
    sw $t2, 768($t1) 
    sw $t2, 1024($t1) 
    sw $t2, 1280($t1)     

#t
    addi $t1, $t1, 8
    sw $t2, 264($t1) 
    sw $t2, 520($t1) 
    sw $t2, 776($t1)  
    sw $t2, 772($t1) 
    sw $t2, 780($t1) 
    sw $t2, 1032($t1) 
    sw $t2, 1288($t1) 
    
    
     #-
    addi $t1, $t1, 24
    sw $t2, 768($t1) 
    sw $t2, 772($t1) 
    sw $t2, 776($t1) 
    
   #q
    addi $t1, $t1, 24
    sw $t2, 0($t1)   
    sw $t2, 4($t1) 
    sw $t2, 8($t1) 
    sw $t2, 12($t1)
    sw $t2, 16($t1)
    sw $t2, 272($t1)
    sw $t2, 528($t1)
    sw $t2, 784($t1)
    sw $t2, 1040($t1)
    sw $t2, 1296($t1)
    sw $t2, 1552($t1)
    sw $t2, 1556($t1)
    sw $t2, 1560($t1)
    sw $t2, 256($t1)  
    sw $t2, 512($t1) 
    sw $t2, 768($t1) 
    sw $t2, 1024($t1)
    sw $t2, 1028($t1)
    sw $t2, 1032($t1)
    sw $t2, 1036($t1)
	lw $t1, baseAddress
	jr $ra

signal:
	# Load the memory-mapped I/O address into register $t9
     li $t9, 0xffff0000     # Load address of keypress flag
    
    
    # Check if 's' is pressed
    lw $t8, 0($t9)   # Load the keyboard status
    
    
    beq $t8, 1, whichKey  # Branch if key is pressed
    
    j signal
    
    whichKey:
    	sw $zero, 0($t9)       # Clear keypress flag
    
    	# Check the key that was pressed
    	lw $t2, 4($t9)         # Load ASCII value of the key
    	
    	beq $t2, 115, game  # ASCII value of 's' is 115
    	beq $t2, 114, startOfGame      # ASCII value of 'r' is 114
    	beq $t2, 113, gameOver     # ASCII value of 'q' is 113
	
	j signal

game:
	jal clearScreen
	jal initialize

gameLoop:
	jal platform
	jal keyboardInput
	jal eraseOld
	jal drawNew
	li $v0, 32
	li $a0, 40 # Wait 1000 milliseconds
	syscall
	j gameLoop
	
	
platform: 
	#increment count
	li $t4, 0
	lw, $t5, character_base #base of character
	addi $t6, $t5, -4 #left block of character
	addi $t5, $t5, 4 #right block of character
	basePlatform:
		addi $t7, $t4, 14592
		addi $t7, $t7, -256
		
		beq $t7, $t5, standOnPlatform
		beq $t7, $t6, standOnPlatform
		
		addi $t4, $t4, 4 #next block
		li $t8, 252
		ble $t4, $t8, basePlatform
		
	li $t4, 0 #counter for # of platforms
	lw $t8, platform_base_location
	li $t7, 0 #counter for which block 
	platformBlock1:
			move $t9, $t7 #copy which block
			sll $t9, $t9, 2 #calculate offset, multiply 4
			add $t9, $t8, $t9 #add offset to get current block
			addi $t9, $t9, -256 #get block above
			
			beq $t9, $t5, standOnPlatform
			beq $t9, $t6, standOnPlatform
			
			
			addi $t7, $t7, 1 #next block
			li $t2, 6
			blt $t7, $t2, platformBlock1 #check if more blocks
			
	lw $t8, platform_base_location+4
	li $t7, 0 #counter for which block 
	platformBlock2:
			move $t9, $t7 #copy which block
			sll $t9, $t9, 2 #calculate offset, multiply 4
			add $t9, $t8, $t9 #add offset to get current block
			addi $t9, $t9, -256 #get block above
			
			beq $t9, $t5, standOnPlatform
			beq $t9, $t6, standOnPlatform
			
			
			addi $t7, $t7, 1 #next block
			li $t2, 6
			blt $t7, $t2, platformBlock2 #check if more blocks
	
	lw $t8, platform_base_location+8
	li $t7, 0 #counter for which block 
	platformBlock3:
			move $t9, $t7 #copy which block
			sll $t9, $t9, 2 #calculate offset, multiply 4
			add $t9, $t8, $t9 #add offset to get current block
			addi $t9, $t9, -256 #get block above
			
			beq $t9, $t5, standOnPlatform
			beq $t9, $t6, standOnPlatform
			
			
			addi $t7, $t7, 1 #next block
			li $t2, 6
			blt $t7, $t2, platformBlock3 #check if more blocks 
			
	lw $t8, platform_base_location+12
	li $t7, 0 #counter for which block 
	platformBlock4:
			move $t9, $t7 #copy which block
			sll $t9, $t9, 2 #calculate offset, multiply 4
			add $t9, $t8, $t9 #add offset to get current block
			addi $t9, $t9, -256 #get block above
			
			beq $t9, $t5, standOnPlatform
			beq $t9, $t6, standOnPlatform
			
			
			addi $t7, $t7, 1 #next block
			li $t2, 6
			blt $t7, $t2, platformBlock4 #check if more blocks 
		
	li $t4, 0
	sw $t4, standPlatform
	j platformNext
	
	standOnPlatform: 
	li $t4, 1
	sw $t4, standPlatform
	
	platformNext:
		jr $ra

keyboardInput:
	# Load the memory-mapped I/O address into register $t9
     li $t9, 0xffff0000     # Load address of keypress flag
    
    # Check if key is pressed
    lw $t8, 0($t9)   # Load the keyboard status
    
    blez $t8, gravity #nothing pressed, check gravity
    
    movement: 
    	sw $zero, 0($t9)       # Clear keypress flag
    
    	# Check the key that was pressed
    	lw $t2, 4($t9)         # Load ASCII value of the key
    	beq $t2, 119, updateUp    # ASCII value of 'w' is 119
    	beq $t2, 97, updateLeft    # ASCII value of 'a' is 97
    	beq $t2, 115, updateShoot   # ASCII value of 's' is 115
    	beq $t2, 100, updateRight  # ASCII value of 'd' is 100
    	beq $t2, 114, startOfGame      # ASCII value of 'r' is 114
    	beq $t2, 113, gameOver     # ASCII value of 'q' is 113
    	
    	lw $t3, standPlatform #check if on platform
	beq $t3, 1, locationNext #on platform
	j gravity
    	
    	
    	updateUp:
		lw $t3, standPlatform #check if on platform
		beq $t3, 0, gravity #not on platform
		
		lw $t3, character_y
		addi $t3, $t3, -8
		bgez $t3, continue
		j gravity
		continue:
		sw $t3, character_y
		lw $t2, new_character #get base of character
		addi $t2, $t2, -2048 #move 4 blocks up
		sw $t2, new_character #update new base
		j updateEnemy
		
	updateRight:
		lw $t2, character_x #get x position
		addi $t2, $t2, 1 #add 1 to it
		
		blt $t2, 64, rightMove #in bounds
		j gravity
		
		
			
		rightMove:
		sw $t2, character_x
		lw $t2, new_character #get base
		addi $t2, $t2, 4 #move one square right
		sw $t2, new_character #update position 
		j gravity
		
	updateLeft:
		lw $t2, character_x #get x position
		addi $t2, $t2, -1 #add -1 to it to get the left block
		li $t1, 1
		bgt $t2, $t1, updateLeftPosition
		j gravity
		updateLeftPosition: 
			sw $t2, character_x
			lw $t2, new_character #get base
			addi $t2, $t2, -4 #move one square left
			sw $t2, new_character #update position 
			j gravity
	
	updateShoot:
		li $t6, 0
		la $t7, shot_x
		shotsLoop:
			move $t8, $t6 #calculate offset and get address
			sll $t8, $t8, 2
			add $t8, $t8, $t7
			
			lw $t8, 0($t8) #get word in array
			beq $zero, $t8, createShot #if zero, found empty slot
			
			addi $t6, $t6, 1 #continue if didn't
			li $t9, 5
			blt $t6, $t9, shotsLoop
			j gravity
			
		createShot:
		la $t8, shot_y	
		lw $t1, character_base #get character
		addi $t1, $t1, BASE_ADDRESS
		lw $t3, character_x #get character x
		lw $t4, character_y #calculate shot y
		addi $t4, $t4, -2 
		sll $t6, $t6, 2 #calculate empty slot in shots array
		add $t7, $t7, $t6
		add $t8, $t6, $t8
		sw $t3, 0($t7) #add shot info to arrays 
		sw $t4, 0($t8) 
		j gravity
		
	gravity:
		lw $t3, standPlatform #check if on platform
		li $t2, 1
		beq $t3, $t2, updateEnemy #On platform
		
		
		lw $t2, new_character #get base of character
		lw $t3, character_y
		li $t4, 56
		bge $t3, 56, updateEnemy
		
		addi $t2, $t2, 256 #move one block down
		addi $t3, $t3, 1
		sw $t2, new_character #update new base
		sw $t3, character_y #update new base
		
	updateEnemy:
		li $t2, 1
		lw $t3, enemy_x
		addi $t3, $t3, -1
		beq $t3, $t2, enemyRight
		
		li $t2, 64
		addi $t3, $t3, 2
		beq $t3, $t2, enemyLeft
		
		lw $t3, enemyDir
		li $t2, 1
		beq $t3, $t2, enemyRight
		
		li $t2, 0
		beq $t3, $t2, enemyLeft
		
		enemyRight: 
			la $t4, enemy_base
			lw $t2, 0($t4)
			addi $t2, $t2, 4
			sw $t2, enemy_new
			lw $t2, enemy_base2
			addi $t2, $t2, 4
			sw $t2, enemy_new2
			lw $t3, enemy_x
			addi $t3, $t3, 1
			li $t5, 1
			sw $t5, enemyDir
			sw $t3, enemy_x
			j updatePlatform
		
		enemyLeft: 
			la $t4, enemy_base
			lw $t2, 0($t4)
			addi $t2, $t2, -4
			sw $t2, enemy_new
			lw $t2, enemy_base2
			addi $t2, $t2, -4
			sw $t2, enemy_new2
			lw $t3, enemy_x
			addi $t3, $t3, -1
			li $t5, 0
			sw $t5, enemyDir
			
			sw $t3, enemy_x
			j updatePlatform
			
	updatePlatform:
		lw $t2, platform_x
		li $t3, 1
		beq $t3, $t2, platformRight
		
		addi $t2, $t2, 5
		li $t3, 64
		beq $t3, $t2, platformLeft
		
		lw $t3, platformDir
		li $t2, 1
		beq $t3, $t2, platformRight
		
		li $t2, 0
		beq $t3, $t2, platformLeft
		
		platformRight:
			lw $t2, platform_base_location+8
			addi $t2, $t2, 4
			sw $t2, platform_new
			lw $t2, platform_base_location+12
			addi $t2, $t2, 4
			sw $t2, platform_new+4
			lw $t3, platform_x
			addi $t3, $t3, 1
			li $t5, 1
			sw $t5, platformDir
			
			sw $t3, platform_x
			j locationNext
			
		platformLeft: 
			lw $t2, platform_base_location+8
			addi $t2, $t2, -4
			sw $t2, platform_new
			lw $t2, platform_base_location+12
			addi $t2, $t2, -4
			sw $t2, platform_new+4
			lw $t3, platform_x
			addi $t3, $t3, -1
			li $t5, 0
			sw $t5, platformDir
			
			sw $t3, platform_x
			j locationNext
		
	locationNext:
		sw $zero, standPlatform
		jr $ra
	
eraseOld:
	lw $t2, character_base
	addi $t2, $t2, BASE_ADDRESS
	sw $zero, 0($t2)
	sw $zero, 4($t2)
	sw $zero, -4($t2)
	sw $zero, -256($t2)
	
	lw $t3, new_character
	sw $t3, character_base
	
	la $t4, enemy_base
	lw $t2, 0($t4)
	addi $t2, $t2, BASE_ADDRESS
	sw $zero, 0($t2)
	sw $zero, -256($t2)
	sw $zero, -252($t2)
	sw $zero, -260($t2)
	lw $t3, enemy_new
	sw $t3, 0($t4)
	
	lw $t2, enemy_base2
	beq $t2, $zero, continueErase
	
	addi $t2, $t2, BASE_ADDRESS
	sw $zero, 0($t2)
	sw $zero, -256($t2)
	sw $zero, -252($t2)
	sw $zero, -260($t2)
	lw $t3, enemy_new2
	sw $t3, enemy_base2
	
	
	continueErase:
	li $t1, 0 #counter for block 
	lw $t2, platform_base_location+8
	addi $t2, $t2, BASE_ADDRESS
	erasePlatform1:
		move $t3, $t1
		sll $t3, $t3, 2
		add $t3, $t2, $t3
		
		sw $zero, 0($t3)
		
		addi $t1, $t1, 1
		li $t4, 6
		blt $t1, $t4, erasePlatform1
	
	li $t1, 0 #counter for block 
	lw $t2, platform_base_location+12
	addi $t2, $t2, BASE_ADDRESS
	erasePlatform2:
		move $t3, $t1
		sll $t3, $t3, 2
		add $t3, $t2, $t3
		
		sw $zero, 0($t3)
		
		addi $t1, $t1, 1
		li $t4, 6
		blt $t1, $t4, erasePlatform2
		
	lw $t3, platform_new
	sw $t3, platform_base_location+8
	
	lw $t3, platform_new+4
	sw $t3, platform_base_location+12
	
	li $t1, 0
	la $t2, shot_x
	la $t3, shot_y
	eraseShots:
		move $t4, $t1 #copy counter twice and calculate offset
		move $t5, $t1
		sll $t5, $t5, 2
		sll $t4, $t4, 2
		add $t4, $t2, $t4
		add $t5, $t3, $t5
		
		lw $t8, 0($t4) #get shot x value
		lw $t9, 0($t5) #get shot y value
		
		beq $t9, $zero, nextShotErase
		beq $t8, $zero, nextShotErase #cannot be 0
		
		sll $t8, $t8, 2 #get the offset from base, multiply by 4 then subtract by 4 to account for x starting at 1 instead of 0
		addi $t8, $t8, -4
		
		sll $t9, $t9, 8 #Symmetrical to above
		addi $t9, $t9, -256
		
		add $t8, $t8, $t9
		addi $t8, $t8, BASE_ADDRESS #get correct block
		
		li $t6, GREEN
		lw $t7, 0($t8)
		beq $t7, GREEN, nextShotErase
		
		sw $zero, 0($t8) #set to black
		j nextShotErase
		
		nextShotErase:
		addi $t1, $t1, 1
		li $t6, 5
		blt $t1, $t6, eraseShots
		
	nextErase:
	jr $ra
	
	
drawNew:
	li $t2, WHITE
	li $t1, BASE_ADDRESS
	lw $t3, character_base 
	add $t3, $t1, $t3
	sw $t2, 0($t3)
	sw $t2, 4($t3)
	sw $t2, -4($t3)
	sw $t2, -256($t3)
	
	li $t2, BLUE
	li $t1, BASE_ADDRESS
	la $t4, enemy_base
	lw $t3, 0($t4)
	add $t3, $t1, $t3
	sw $t2, 0($t3)
	sw $t2, -256($t3)
	sw $t2, -252($t3)
	sw $t2, -260($t3)
	
	#if the entries are 0 for enemy, means it was hit and we should not draw
	lw $t3, enemy_base2
	beq $zero, $t3, collision
	
	add $t3, $t1, $t3
	sw $t2, 0($t3)
	sw $t2, -256($t3)
	sw $t2, -252($t3)
	sw $t2, -260($t3)
	
	collision:
	#check for collisions
	li $t4, BLUE
	li $t5, MIX1
	lw $t3, character_base 
	add $t3, $t1, $t3
	
	lw $t2, 260($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	lw $t2, 8($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	lw $t2, 256($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	lw $t2, 252($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	lw $t2, -8($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	lw $t2, -252($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	lw $t2, -260($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	lw $t2, -512($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	lw $t2, -516($t3)
	beq $t2, $t4, reduceLife
	beq $t2, $t5, newLife
	
	j drawRest
	
	reduceLife:
		lw $t4, lives #get the heart to remove
		addi $t4, $t4, -1
		la $t5, lifeLocation
		sll $t4, $t4, 2
		add $t5, $t4, $t5
		lw $t5, 0($t5)
		addi $t5, $t5, BASE_ADDRESS
		
		sw $zero, 0($t5) 
    		sw $zero, 4($t5) 
    		sw $zero, 256($t5)
    		sw $zero, 252($t5)
    		sw $zero, 260($t5)
    		sw $zero, 264($t5)
    		sw $zero, 512($t5)
    		sw $zero, 508($t5)
		sw $zero, 516($t5)
    		sw $zero, 520($t5)
    		sw $zero, 768($t5)
    		sw $zero, 772($t5)
    		lw $t4, lives
    		addi $t4, $t4, -1
    		sw $t4, lives
		
		beq $t4, $zero, gameOver
		j drawRest
		
	newLife:
		lw $t4, lives
		li $t5, 3
		beq $t4, $t5, drawRest
		
		li $t5, 2
		beq $t4, $t5, twoLives
		
		li $t5, 1
		beq $t4, $t5, oneLife
		
		twoLives:
			lw $t6, lifeLocation+8
			addi $t6, $t6, BASE_ADDRESS
			li $t2, RED
			sw $t2, 0($t6) 
    		sw $t2, 4($t6) 
    		sw $t2, 256($t6)
    		sw $t2, 252($t6)
    		sw $t2, 260($t6)
    		sw $t2, 264($t6)
    		sw $t2, 512($t6)
    		sw $t2, 508($t6)
		sw $t2, 516($t6)
    		sw $t2, 520($t6)
    		sw $t2, 768($t6)
    		sw $t2, 772($t6)
		lw $t2, lives
		addi $t2, $t2, 1
		sw $t2, lives
		j drawRest
		
		oneLife:
		lw $t6, lifeLocation+4
			addi $t6, $t6, BASE_ADDRESS
			li $t2, RED
			sw $t2, 0($t6) 
    		sw $t2, 4($t6) 
    		sw $t2, 256($t6)
    		sw $t2, 252($t6)
    		sw $t2, 260($t6)
    		sw $t2, 264($t6)
    		sw $t2, 512($t6)
    		sw $t2, 508($t6)
		sw $t2, 516($t6)
    		sw $t2, 520($t6)
    		sw $t2, 768($t6)
    		sw $t2, 772($t6)
		lw $t2, lives
		addi $t2, $t2, 1
		sw $t2, lives
		j drawRest
		
	drawRest:
	li $t1, 0 #counter for block 
	lw $t2, platform_base_location+8
	addi $t2, $t2, BASE_ADDRESS
	li $t5, GREEN
	createPlatform1:
		move  $t3, $t1
		sll $t3, $t3, 2
		add $t3, $t2, $t3
		
		sw $t5, 0($t3)
		
		addi $t1, $t1, 1
		li $t4, 6
		blt $t1, $t4, createPlatform1
	
	li $t1, 0 #counter for block 
	lw $t2, platform_base_location+12
	addi $t2, $t2, BASE_ADDRESS
	li $t5, GREEN
	createPlatform2:
		move  $t3, $t1
		sll $t3, $t3, 2
		add $t3, $t2, $t3
		
		sw $t5, 0($t3)
		
		addi $t1, $t1, 1
		li $t4, 6
		blt $t1, $t4, createPlatform2
	
	li $t1, 0
	drawShots:
		la $t2, shot_x
		la $t3, shot_y
		move $t4, $t1 #copy counter twice and calculate offset
		move $t5, $t1
		sll $t5, $t5, 2
		sll $t4, $t4, 2
		add $t4, $t2, $t4
		add $t5, $t3, $t5
		
		lw $t4, 0($t4) #get shot x value
		lw $t8, 0($t5) #get shot y value
		
		beq $t8, $zero, nextShot
		beq $t4, $zero, nextShot #cannot be 0
		
		addi $t8, $t8, -1 #increment y value
		beqz $t8, reduceShot
		
		sw $t8, 0($t5) #update y value
		
		sll $t4, $t4, 2 #get the offset from base, multiply by 4 then subtract by 4 to account for x starting at 1 instead of 0
		addi $t4, $t4, -4
		
		sll $t8, $t8, 8 #Symmetrical to above
		addi $t8, $t8, -256
		
		add $t4, $t4, $t8 #add offsets
		addi $t4, $t4, BASE_ADDRESS #get correct block
		
		lw $t9, 0($t4)
		li $t7, RED
		beq $t9, $t7, reduceRed
		
		li $t7, GREEN
		beq $t9, $t7, fixPlatform
		
		li $t7, BLUE
		beq $t9, $t7, deleteEnemy
		j continueDraw
		
		reduceShot:
		move $t4, $t1 #copy counter twice and calculate offset
		sll $t4, $t4, 2
		add $t4, $t2, $t4
		sw $zero, 0($t5)
		sw $zero, 0($t4)
		j nextShot
		
		deleteEnemy:
		lw $t6, enemy_base2
		addi $t6, $t6, BASE_ADDRESS
		sw $zero, 0($t6)
		sw $zero, -256($t6)
		sw $zero, -260($t6)
		sw $zero, -252($t6)
		sw $zero, enemy_base2
		sw $zero, enemy_new2
		
		continueDraw:
		li $t7, MIX
		sw $t7, 0($t4) #set to purple
		j nextShot
		
		reduceRed:
			sw $zero, 0($t4)
			
			#set old block to black
			sw $zero, 256($t4)
			
			move $t4, $t1 #copy counter twice and calculate offset
			move $t5, $t1
			sll $t5, $t5, 2
			sll $t4, $t4, 2
			add $t4, $t2, $t4
			add $t5, $t3, $t5
			
			#make array entries 0
			sw $zero, 0($t4)
			sw $zero, 0($t5)
			
			#reduce # of blocks
			lw $t7, numBlocks
			addi $t7, $t7, -1
			sw $t7, numBlocks
			lw $t8, numBlocksDestroyed
			addi $t8, $t8, 1
			sw $t8, numBlocksDestroyed
			beq $t8, 8, score1
			beq $t8, 16, score2
			beq $t8, 24, score3
			beq $t8, 32, score4
			beq $t8, 40, score5
			beq $t8, 48, score6
			beq $t8, 56, score7
			beq $t8, 64, score8
			beq $t8, 72, score9
			beq $t8, 80, score10
			beq $t8, 88, score11
			beq $t8, 96, score12
			beq $t8, 104, score13
			beq $t8, 112, score14
			beq $t8, 120, score15
			j continueShot
			
			score1: 
				li $t8, 1
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 296
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score2: 
				li $t8, 2
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 300
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score3: 
				li $t8, 3
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 304
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score4: 
				li $t8, 4
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 308
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score5: 
				li $t8, 5
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 312
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score6: 
				li $t8, 6
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 316
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score7: 
				li $t8, 7
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 320
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score8: 
				li $t8, 8
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 324
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score9: 
				li $t8, 9
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 328
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score10: 
				li $t8, 10
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 332
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score11: 
				li $t8, 11
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 336
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score12: 
				li $t8, 12
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 340
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score13: 
				li $t8, 13
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 344
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score14: 
				li $t8, 6
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 348
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot
			score15: 
				li $t8, 15
				sw $t8, score
				lw $t8, lifeLocation+8
				addi $t8, $t8, 352
				li $t2, MIX1
				addi $t8, $t8, BASE_ADDRESS
				sw $t2, 0($t8)
				j continueShot

			continueShot:
			lw $t7, numBlocks
			beq $t7, $zero, youWin
			j nextShot
			
		fixPlatform:
			li $t7, GREEN
			sw $t7, 0($t4)
			j nextShot
			
		nextShot:
		addi $t1, $t1, 1
		li $t6, 5
		blt $t1, $t6, drawShots
	
	drawHeart:
	lw $t1, heart
	addi $t1, $t1, BASE_ADDRESS
	li $t2, MIX1
      	sw $t2, 0($t1)
       sw $t2, -256($t1)
        sw $t2, -260($t1)
         sw $t2, -252($t1)
          sw $t2, -512($t1)
           sw $t2, -516($t1)
            sw $t2, -520($t1)
             sw $t2, -508($t1)
              sw $t2, -504($t1)
              sw $t2, -768($t1)
              sw $t2, -772($t1)
              sw $t2, -764($t1)
             
	nextDraw:
	jr $ra
	
initialize:
	# Load the base address into register $t1
    	li $t1, BASE_ADDRESS
    	
    	 #Load red
    li $t2, RED
    
     # Write "Life - "
    #L 
    addi $t1, $t1, 15104
    sw $t2, 0($t1)       
    sw $t2, 256($t1)  
    sw $t2, 512($t1) 
    sw $t2, 768($t1)
    sw $t2, 1024($t1)
    sw $t2, 1028($t1)
    sw $t2, 1032($t1)     
    	
#i
addi $t1, $t1, 16
    sw $t2, 0($t1) 
    sw $t2, 512($t1) 
    sw $t2, 768($t1) 
    sw $t2, 1024($t1) 
    
    #f
 addi $t1, $t1, 16
    sw $t2, 0($t1) 
    sw $t2, 4($t1)
    sw $t2, 256($t1) 
    sw $t2, 512($t1) 
    sw $t2, 508($t1)
    sw $t2, 516($t1) 
    sw $t2, 768($t1)  
    sw $t2, 1024($t1)
    
    #e
    addi $t1, $t1, 16
    sw $t2, 0($t1) 
    sw $t2, 4($t1) 
    sw $t2, 8($t1) 
    sw $t2, 256($t1)
    sw $t2, 512($t1)  
    sw $t2, 516($t1) 
    sw $t2, 520($t1) 
    sw $t2, 264($t1) 
    sw $t2, 768($t1) 
    sw $t2, 1024($t1)
    sw $t2, 1028($t1)  
    sw $t2, 1032($t1) 
	
	#-
    addi $t1, $t1, 16
    sw $t2, 512($t1) 
    sw $t2, 516($t1) 
    sw $t2, 520($t1)
    
    #hearts
    addi $t1, $t1, 20
    sw $t2, 0($t1) 
    sw $t2, 4($t1) 
    sw $t2, 256($t1)
    sw $t2, 252($t1)
    sw $t2, 260($t1)
    sw $t2, 264($t1)
    sw $t2, 512($t1)
    sw $t2, 508($t1)
    sw $t2, 516($t1)
    sw $t2, 520($t1)
    sw $t2, 768($t1)
    sw $t2, 772($t1)
    li $t3, 15188
    sw $t3, lifeLocation
 
    
    addi $t1, $t1, 20
    sw $t2, 0($t1) 
    sw $t2, 4($t1) 
    sw $t2, 256($t1)
    sw $t2, 252($t1)
    sw $t2, 260($t1)
    sw $t2, 264($t1)
    sw $t2, 512($t1)
    sw $t2, 508($t1)
    sw $t2, 516($t1)
    sw $t2, 520($t1)
    sw $t2, 768($t1)
    sw $t2, 772($t1)
     li $t3, 15208
    sw $t3, lifeLocation+4
    
    addi $t1, $t1, 20
    sw $t2, 0($t1) 
    sw $t2, 4($t1) 
    sw $t2, 256($t1)
    sw $t2, 252($t1)
    sw $t2, 260($t1)
    sw $t2, 264($t1)
    sw $t2, 512($t1)
    sw $t2, 508($t1)
    sw $t2, 516($t1)
    sw $t2, 520($t1)
    sw $t2, 768($t1)
    sw $t2, 772($t1)
    li $t3, 15228
    sw $t3, lifeLocation+8
    
    li $t1, 3
    sw $t1, lives
    
     # Load the base address into register $t1
    	li $t1, BASE_ADDRESS
    	li $t3, 256
    	li $t2, GREEN
    	#Fill line separating game from stats
    	lines:  
    		#Load red
    		 sw $t2, 14592($t1) 
    		 
    		 #Increment
    		 addi $t1, $t1, 4
    		 
    		 #Reduce by 4
    		 addi $t3, $t3, -4
    		 
    		 # Repeat the loop until all pixels are cleared
    		bnez $t3, lines
    		 
    
      # Load the base address into register $t1
    	li $t1, BASE_ADDRESS
    	li $t3, 248
    	li $t2, RED
    	#Fill three rows with red blocks 
    	blocks:  
    		#Load red
    		 sw $t2, 4($t1) 
    		 
    		 #Increment
    		 addi $t1, $t1, 4
    		 
    		 #Reduce by 4
    		 addi $t3, $t3, -4
    		 
    		 # Repeat the loop until all pixels are cleared
    		bnez $t3, blocks
    	
    	# Load the base address into register $t1
    	li $t1, BASE_ADDRESS
    	li $t3, 232
    	li $t2, RED
    	#Fill three rows with red blocks 
    	blocks1:  
    		#Load red
    		 sw $t2, 268($t1) 
    		 
    		 #Increment
    		 addi $t1, $t1, 4
    		 
    		 #Reduce by 4
    		 addi $t3, $t3, -4
    		 
    		 # Repeat the loop until all pixels are cleared
    		bnez $t3, blocks1
    
    	li $t1, 120
    	sw $t1, numBlocks
    	
     #Load character
    li $t1, BASE_ADDRESS
    li $t2, 14340	 
    add $t1, $t1, $t2
    sw $t2, character_base
    sw $t2, new_character
    li $t2, 2
    sw $t2, character_x
    li $t2, 55
    sw $t2, character_y

    li $t2, WHITE
    sw $t2, 0($t1) 
    sw $t2, 4($t1) 
    sw $t2, -4($t1)
    sw $t2, -256($t1) 
    
    #Load enemy 
    la $s1, enemy_base
    li $t1, BASE_ADDRESS
    li $t2, 14584
    add $t1, $t1, $t2
    sw $t2, 0($s1)	 
    sw $t2, enemy_new	 
    li $t2, BLUE
    sw $t2, 0($t1) 
    sw $t2, -256($t1) 
    sw $t2, -252($t1) 
    sw $t2, -260($t1) 
    li $t2, 63
    sw $t2, enemy_x
    li $t2, 11512
    sw $t2, enemy_base2
    sw $t2, enemy_new2
    addi $t2, $t2, BASE_ADDRESS
    li $t3, BLUE
    sw $t3, 0($t1) 
    sw $t3, -256($t2) 
    sw $t3, -252($t2) 
    sw $t3, -260($t2) 
    
     

	#platforms
	la $s0, platform_base_location
	 li $t1, BASE_ADDRESS	
     li $t2, GREEN
     addi $t1, $t1, 13056
     li $t3, 13056
     sw $t2, 0($t1) 
     sw, $t3, 0($s0)
    sw $t2, 4($t1) 
    sw $t2, 8($t1)
    sw $t2, 12($t1) 
    sw $t2, 16($t1)
     sw $t2, 20($t1)
    sw $t2, 252($t1) 
    sw $t2, 248($t1) 
    sw $t2, 244($t1)
     sw $t2, 240($t1)
      sw $t2, 236($t1)
      sw $t2, 232($t1)
      li $t3, 13288
      sw $t3, 4($s0)
      sw $t2, 532($t1) 
    sw $t2, 528($t1) 
    sw $t2, 524($t1) 
    sw $t2, 520($t1)
     sw $t2, 516($t1)
      sw $t2, 512($t1)
      li $t3, 13568
      sw $t3, 8($s0)
      sw $t3, platform_new
      addi $t3, $t3, -256
      addi $t3, $t3, -256
      addi $t3, $t3, -256
      addi $t3, $t3, -256
      addi $t3, $t3, -256
      addi $t3, $t3, -256
      addi $t3, $t3, -256
      li $t1, BASE_ADDRESS
      add $t1, $t1, $t3
      sw $t2, 0($t1)
      sw $t2, 4($t1)
      sw $t2, 8($t1)
      sw $t2, 12($t1)
      sw $t2, 16($t1)
      sw $t3, platform_new+4
      sw $t3, 12($s0)
      li $t3, 1
      sw $t3, platformDir
      sw $t3, platform_x
      
      li $t1, BASE_ADDRESS
      addi $t1, $t1, 12848
      li $t2, MIX1
      sw $t2, 0($t1)
       sw $t2, -256($t1)
        sw $t2, -260($t1)
         sw $t2, -252($t1)
          sw $t2, -512($t1)
           sw $t2, -516($t1)
            sw $t2, -520($t1)
             sw $t2, -508($t1)
              sw $t2, -504($t1)
              sw $t2, -768($t1)
              sw $t2, -772($t1)
              sw $t2, -764($t1)
        li $t2, 12848
        sw $t2, heart
   
   
   #score 
   lw $t2, lifeLocation+8
   addi $t2, $t2, 36
   li $t3, RED
   addi $t2, $t2, BASE_ADDRESS
   sw $t3, 0($t2)
   sw $t3, 256($t2)
   sw $t3, 512($t2)
   sw $t3, 4($t2)
   sw $t3, 8($t2)
   sw $t3, 12($t2)
   sw $t3, 16($t2)
   sw $t3, 20($t2)
   sw $t3, 24($t2)
   sw $t3, 28($t2)
   sw $t3, 32($t2)
   sw $t3, 36($t2)
   sw $t3, 40($t2)
   sw $t3, 44($t2)
   sw $t3, 48($t2)
   sw $t3, 52($t2)
   sw $t3, 56($t2)
   sw $t3, 56($t2)
   sw $t3, 60($t2)
   sw $t3, 64($t2)
   sw $t3, 320($t2)
   sw $t3, 516($t2)
   sw $t3, 520($t2)
   sw $t3, 524($t2)
   sw $t3, 528($t2)
   sw $t3, 532($t2)
   sw $t3, 536($t2)
   sw $t3, 540($t2)
   sw $t3, 544($t2)
   sw $t3, 548($t2)
   sw $t3, 552($t2)
   sw $t3, 556($t2)
   sw $t3, 560($t2)
   sw $t3, 564($t2)
   sw $t3, 568($t2)
   sw $t3, 572($t2)
   sw $t3, 576($t2)
   
    jr $ra
    
    youWin:
   jal clearScreen
    # Load the base address into register $t1
    	li $t1, BASE_ADDRESS
    	li $t3, 4096
    	li $t4, 0
    li $t2, 0xfff7f7fa
   winBackground:
    	move $t5, $t4
    	sll $t5, $t5, 2
    	add $t5, $t5, $t1
    	sw $t2, 0($t5)
    	addi $t4, $t4, 1
    	addi $t3, $t3, -1
    	bgtz $t3, winBackground
    	
    	li $t2, BLUE
    	
    	#Y
    	li $t1, BASE_ADDRESS
    	addi $t1, $t1, 2580
    	sw $t2, 0($t1)
    	sw $t2, 260($t1)
    	sw $t2, 520($t1)
    	sw $t2, 16($t1)
    	sw $t2, 268($t1)
    	sw $t2, 776($t1)
    	sw $t2, 1032($t1)
    	sw $t2, 1288($t1)
    	
    	
    	#O
    	addi $t1, $t1, 24
    	sw $t2, 4($t1)
    	sw $t2, 8($t1)
    	sw $t2, 268($t1)
    	sw $t2, 524($t1)
    	sw $t2, 780($t1)
    	sw $t2, 1036($t1)
    	sw $t2, 256($t1)
    	sw $t2, 512($t1)
    	sw $t2, 768($t1)
    	sw $t2, 1024($t1)
    	sw $t2, 1284($t1)
    	sw $t2, 1288($t1)
   	 
   	  #u
    addi $t1, $t1, 280
    sw $t2, 0($t1)   
    sw $t2, 256($t1)   
    sw $t2, 512($t1) 
    sw $t2, 768($t1) 
    sw $t2, 1028($t1)
    sw $t2, 1032($t1) 
    sw $t2, 1036($t1) 
    sw $t2, 16($t1)   
       sw $t2, 272($t1)   
    sw $t2, 528($t1) 
    sw $t2, 784($t1) 

   	 
   	 #W
   	 li $t1, BASE_ADDRESS
   	 addi $t1, $t1, 5936
   	 sw $t2, 0($t1)
    	sw $t2, 260($t1)
    	sw $t2, 520($t1)
    	sw $t2, 268($t1)
    	sw $t2, 16($t1)
    	sw $t2, 276($t1)
    	sw $t2, 536($t1)
    	sw $t2, 284($t1)
    	sw $t2, 32($t1)
    	
    	
    	
    	#i
    	li $t1, BASE_ADDRESS
   	 addi $t1, $t1, 5168
addi $t1, $t1, 40
    sw $t2, 0($t1) 
    sw $t2, 512($t1) 
    sw $t2, 768($t1) 
    sw $t2, 1024($t1) 
    sw $t2, 1280($t1)  
    
    #n
addi $t1, $t1, 12
sw $t2, 0($t1)
	sw $t2, 256($t1)
    sw $t2, 512($t1) 
    sw $t2, 768($t1)
    sw $t2, 1024($t1)
    sw $t2, 1280($t1)
    sw $t2, 260($t1)
    sw $t2, 264($t1)
    sw $t2, 268($t1)
    sw $t2, 524($t1)
    sw $t2, 780($t1)
    sw $t2, 1036($t1)
    sw $t2, 1292($t1)

    
    	#!
addi $t1, $t1, 24
    sw $t2, 0($t1) 
     sw $t2, 256($t1) 
    sw $t2, 512($t1)  
    sw $t2, 768($t1) 
    sw $t2, 1280($t1) 
    j quitGame
    
    	
    	
    gameOver:
      jal clearScreen
    # Load the base address into register $t1
    	li $t1, BASE_ADDRESS
    	li $t3, 4096
    	li $t4, 0
    li $t2, 0xfff7f7fa
   overBackground:
    	move $t5, $t4
    	sll $t5, $t5, 2
    	add $t5, $t5, $t1
    	sw $t2, 0($t5)
    	addi $t4, $t4, 1
    	addi $t3, $t3, -1
    	bgtz $t3, overBackground
    	
    	
    	li $t2, BLUE
    	
    	#G
    	li $t1, BASE_ADDRESS
    	addi $t1, $t1, 2580
    	sw $t2, 4($t1)
    	sw $t2, 8($t1)
    	sw $t2, 12($t1)
    	sw $t2, 16($t1)
    	sw $t2, 20($t1)
    	sw $t2, 256($t1)
    	sw $t2, 512($t1)
    	sw $t2, 768($t1)
    	sw $t2, 1024($t1)
    	sw $t2, 1284($t1)
    	sw $t2, 1288($t1)
    	sw $t2, 1292($t1)
    	sw $t2, 1296($t1)
    	sw $t2, 1300($t1)
    	sw $t2, 1048($t1)
    	sw $t2, 792($t1)
    	sw $t2, 532($t1)
    	sw $t2, 528($t1)
    	sw $t2, 524($t1)
    	
    	#a
    	addi $t1, $t1, 32
    	sw $t2, 0($t1)
    	sw $t2, 4($t1)
    	sw $t2, 8($t1)
    	sw $t2, 12($t1)
    	sw $t2, 272($t1)
    	sw $t2, 528($t1)
    	sw $t2, 524($t1)
    	sw $t2, 520($t1)
    	sw $t2, 516($t1)
    	sw $t2, 512($t1)
    	sw $t2, 768($t1)
    	sw $t2, 1024($t1)
    	sw $t2, 1280($t1)
    	sw $t2, 1284($t1)
    	sw $t2, 1288($t1)
    	sw $t2, 1292($t1)
    	sw $t2, 1296($t1)
    	sw $t2, 1040($t1)
    	sw $t2, 784($t1)
    	
    	#m
   	addi $t1, $t1, 28
   	sw $t2, 4($t1)
   	sw $t2, 8($t1)
   	sw $t2, 256($t1)
   	sw $t2, 512($t1)
   	sw $t2, 768($t1)
   	sw $t2, 1024($t1)
   	sw $t2, 268($t1)
   	sw $t2, 528($t1)
   	sw $t2, 276($t1)
   	sw $t2, 24($t1)
   	sw $t2, 28($t1)
   	sw $t2, 288($t1)
   	sw $t2, 544($t1)
   	sw $t2, 800($t1)
   	sw $t2, 1056($t1)
   	sw $t2, 1312($t1)
   	sw $t2, 1280($t1)
   	
   	#e 
   	addi $t1, $t1, 40
   	sw $t2, 4($t1)
   	sw $t2, 8($t1)
   	sw $t2, 12($t1)
   	sw $t2, 16($t1)
   	sw $t2, 276($t1)
   	sw $t2, 532($t1)
   	sw $t2, 784($t1)
   	sw $t2, 780($t1)
   	sw $t2, 776($t1)
   	sw $t2, 772($t1)
   	sw $t2, 4($t1)
   	sw $t2, 4($t1)
   	sw $t2, 256($t1)
   	sw $t2, 512($t1)
   	sw $t2, 768($t1)
   	sw $t2, 1024($t1)
   	sw $t2, 1284($t1)
   	sw $t2, 1288($t1)
   	sw $t2, 1292($t1)
   	sw $t2, 1296($t1)
   	sw $t2, 1300($t1)
   	
   	#O
   	li $t1, BASE_ADDRESS
    	addi $t1, $t1, 5180
    	sw $t2, 4($t1)
    	sw $t2, 8($t1)
    	sw $t2, 268($t1)
    	sw $t2, 524($t1)
    	sw $t2, 780($t1)
    	sw $t2, 1036($t1)
    	sw $t2, 256($t1)
    	sw $t2, 512($t1)
    	sw $t2, 768($t1)
    	sw $t2, 1024($t1)
    	sw $t2, 1284($t1)
    	sw $t2, 1288($t1)
    	
    	#V
    	addi $t1, $t1, 24  
    	sw $t2, 0($t1)
    	sw $t2, 260($t1)
    	sw $t2, 520($t1)
    	sw $t2, 780($t1)
    	sw $t2, 1040($t1)
    	sw $t2, 1300($t1)
    	sw $t2, 1048($t1)
    	sw $t2, 796($t1)
    	sw $t2, 544($t1)
    	sw $t2, 292($t1)
    	sw $t2, 40($t1)
    	
    	#e 
   	addi $t1, $t1, 48
   	sw $t2, 4($t1)
   	sw $t2, 8($t1)
   	sw $t2, 12($t1)
   	sw $t2, 16($t1)
   	sw $t2, 276($t1)
   	sw $t2, 532($t1)
   	sw $t2, 784($t1)
   	sw $t2, 780($t1)
   	sw $t2, 776($t1)
   	sw $t2, 772($t1)
   	sw $t2, 4($t1)
   	sw $t2, 4($t1)
   	sw $t2, 256($t1)
   	sw $t2, 512($t1)
   	sw $t2, 768($t1)
   	sw $t2, 1024($t1)
   	sw $t2, 1284($t1)
   	sw $t2, 1288($t1)
   	sw $t2, 1292($t1)
   	sw $t2, 1296($t1)
   	sw $t2, 1300($t1)
   	
   	#r
   	addi $t1, $t1, 32
   	sw $t2, 256($t1)
   	sw $t2, 512($t1)
   	sw $t2, 768($t1)
   	sw $t2, 1024($t1)
   	sw $t2, 1280($t1)
   	sw $t2, 4($t1)
   	sw $t2, 8($t1)
   	sw $t2, 12($t1)
   	sw $t2, 16($t1)
    j quitGame
    
# quit game
quitGame:
	li $v0, 10 
	syscall
