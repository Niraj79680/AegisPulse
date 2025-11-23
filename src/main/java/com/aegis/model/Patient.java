package com.aegis.model;

public class Patient {
    private int id;
    private String name;
    private int age;
    private int heartRate;
    private int oxygenLevel;
    private int painLevel;
    private String symptoms;
    private int triageScore;
    private String triageColor;

    public Patient(int id, String name, int age, int heartRate, int oxygenLevel, int painLevel, String symptoms, int triageScore, String triageColor) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.heartRate = heartRate;
        this.oxygenLevel = oxygenLevel;
        this.painLevel = painLevel;
        this.symptoms = symptoms;
        this.triageScore = triageScore;
        this.triageColor = triageColor;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public int getAge() { return age; }
    public int getHeartRate() { return heartRate; }
    public int getOxygenLevel() { return oxygenLevel; }
    public int getPainLevel() { return painLevel; }
    public String getSymptoms() { return symptoms; }
    public int getTriageScore() { return triageScore; }
    public String getTriageColor() { return triageColor; }
}