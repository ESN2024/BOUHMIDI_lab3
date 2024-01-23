#include<stdio.h>
#include<stdint.h>
#include "system.h"
#include <io.h>
#include "altera_avalon_pio_regs.h"
#include "sys/alt_stdio.h"
#include <unistd.h>
#include <sys/alt_irq.h>
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_timer.h"
#include "opencores_i2c.h"
#include "opencores_i2c_regs.h"



#define SPEED_FREQ 400000
#define ADDR_REG 0x1D

#define DATAX0 0x32
#define DATAX1 0x33
#define DATAY0 0x34
#define DATAY1 0x35
#define DATAZ0 0x36
#define DATAZ1 0x37


__int32_t data_x;
__int32_t data_y;
__int32_t data_z;
	



__int32_t I2C_read_gyro(__int16_t reg)
{
	__int32_t data = 0;
	
	I2C_start(OPENCORES_I2C_0_BASE, ADDR_REG, 0);
	
	I2C_write(OPENCORES_I2C_0_BASE, reg, 0);
	
	I2C_start(OPENCORES_I2C_0_BASE, ADDR_REG, 1);	
	
	data = I2C_read(OPENCORES_I2C_0_BASE, 1);
	
	return data;
}



void I2C_write_gyro(alt_u8 data, __int16_t reg)
{
	I2C_start(OPENCORES_I2C_0_BASE , ADDR_REG, 0);
	
	I2C_write(OPENCORES_I2C_0_BASE, reg, 0);
	
	I2C_write(OPENCORES_I2C_0_BASE, data, 1);
}

void handle_timer_interrupt(void*p, alt_u32 param)

{
	__int32_t data_x_lsb; 
	__int32_t data_x_msb; 
	__int32_t data_y_lsb;
	__int32_t data_y_msb;
	__int32_t data_z_lsb;
	__int32_t data_z_msb;

	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0b1);
	
	
	data_x_lsb = I2C_read_gyro(DATAX0);
	data_x_msb = I2C_read_gyro(DATAX1);
	data_y_lsb = I2C_read_gyro(DATAY0);
	data_y_msb = I2C_read_gyro(DATAY1);
	data_z_lsb = I2C_read_gyro(DATAZ0);
	data_z_msb = I2C_read_gyro(DATAZ1);
	
	data_x = (data_x_msb << 8) | data_x_lsb;
	data_y = (data_y_msb << 8) | data_y_lsb;
	data_z = (data_z_msb << 8) | data_z_lsb;
	
	alt_printf("X = %x\n", data_x);
	alt_printf("Y = %x\n", data_y);
	alt_printf("Z = %x\n", data_z);
	



}








int main()
{

	
	I2C_init(OPENCORES_I2C_0_BASE, ALT_CPU_CPU_FREQ, SPEED_FREQ);
	

	
	
	
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,ALTERA_AVALON_TIMER_CONTROL_CONT_MSK | ALTERA_AVALON_TIMER_CONTROL_START_MSK | ALTERA_AVALON_TIMER_CONTROL_ITO_MSK);
	alt_irq_register(TIMER_0_IRQ,NULL,handle_timer_interrupt);
	
	
	while (1)
	{

		
	}
	return 0;
}