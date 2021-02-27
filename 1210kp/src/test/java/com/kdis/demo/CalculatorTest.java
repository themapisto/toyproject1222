package com.kdis.demo;

import org.junit.Test;
import static org.junit.Assert.*;



public class CalculatorTest {                                           
    @Test                                                                               
    public void testSum(){                                                        
        Calculator c = new Calculator();
        double result = c.sum(10, 50);                                   
        assertEquals(60, result, 0); 
        
        double result2= c.sum(20, 30);
        assertEquals(40,result2,0);
    }
}
