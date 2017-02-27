/*
 * pwmpot.asm
 *
 *  Created: 3/25/2016 1:32:01 PM
 *   Author: Oren Collaco
 */ 

 ser r18
 out ddrb,r18
 ser r18
 out ddrd,r18
 ldi r18,0xa1				//8-bit PWM
 out tccr1a,r18
 ldi r18,0x01				//Timer1 clock speed = CPU speed
 out tccr1b,r18
 cbi admux,refs1
 sbi admux,refs0
 sbi admux,adlar
 sbi adcsra,aden
 sbi adcsra,adfr
 sbi adcsra,adsc
  looop:             
 poll_adif:
 sbis adcsra,adif	     //voltage at ad0(controlled by POT) pin will be available in adch register when adif is set
 rjmp poll_adif			
 in r16,adch             //voltage value in register adch is copied to register r16
 out ocr1bl,r16		     //Voltage in r16 is copied to register ocr1bl which decides the pwm duty cycle and thus the speed of the motor
 rjmp looop