package com.aegis.logic;

import org.junit.Test;
import static org.junit.Assert.*;

public class TriageLogicTest {

    @Test
    public void testSeverityCalculation() {
        TriageLogic logic = new TriageLogic();

        int severity = logic.calculateSeverityScore(
                80,          // heartRate
                96,          // oxygenLevel
                2,           // painLevel
                "chest pain" // symptoms
        );

        assertTrue(severity >= 0 && severity <= 100);
    }

    @Test
    public void testTriageColorNotNull() {
        TriageLogic logic = new TriageLogic();

        int severity = logic.calculateSeverityScore(
                110,
                92,
                6,
                "difficulty breathing"
        );

        String color = logic.getTriageColor(severity);

        assertNotNull(color);
    }
}
