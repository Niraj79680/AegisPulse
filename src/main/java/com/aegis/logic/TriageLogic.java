package com.aegis.logic;

public class TriageLogic {

    /**
     * Calculates a severity score (0-100) based on vitals and symptoms.
     * This is the "Rule-Based AI" component.
     */
    public int calculateSeverityScore(int heartRate, int oxygenLevel, int painLevel, String symptoms) {
        int score = 0;

        // 1. Evaluate Vitals
        if (oxygenLevel < 90) score += 40; // Critical hypoxia
        else if (oxygenLevel < 95) score += 20;

        if (heartRate > 120 || heartRate < 40) score += 30; // Dangerous arrhythmia
        else if (heartRate > 100) score += 10;

        // 2. Evaluate Pain (Weighted)
        score += (painLevel * 3); // Pain creates urgency

        // 3. Keyword Analysis (NLP-lite)
        if (symptoms != null) {
            String s = symptoms.toLowerCase();
            if (s.contains("chest pain") || s.contains("heart attack")) {
                score += 50; // Immediate critical flag
            }
            if (s.contains("bleeding") || s.contains("unconscious")) {
                score += 40;
            }
            if (s.contains("difficulty breathing")) {
                score += 35;
            }
        }

        // Cap score at 100
        return Math.min(score, 100);
    }

    /**
     * Determines the Triage Color Code based on the score.
     */
    public String getTriageColor(int score) {
        if (score >= 75) return "RED";    // Immediate Resuscitation
        if (score >= 40) return "YELLOW"; // Urgent
        return "GREEN";                   // Non-Urgent
    }
}
