package com.aegis.controller;

import com.aegis.logic.TriageLogic;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Integration test:
 * Controller + Logic interaction (no servlet container)
 */
public class ComplaintIntegrationTest {

    @Test
    public void testComplaintTriageFlow() {
        // Simulating controller behavior
        TriageLogic logic = new TriageLogic();

        int severity = logic.calculateSeverityScore(
                95,                 // heart rate
                92,                 // oxygen
                5,                  // pain
                "difficulty breathing"
        );

        String color = logic.getTriageColor(severity);

        // Integration assertions
        assertTrue(severity >= 0 && severity <= 100);
        assertNotNull(color);
        assertTrue(
                color.equals("RED") ||
                        color.equals("YELLOW") ||
                        color.equals("GREEN")
        );
    }
}

