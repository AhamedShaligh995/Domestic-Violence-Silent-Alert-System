// ─────────────────────────────────────────────────────────────────────────────
// TWILIO CALL DIAGNOSTIC TEST
// ─────────────────────────────────────────────────────────────────────────────
// HOW TO RUN (from the aad folder in PowerShell):
//   javac -cp "lib\*" TwilioCallTest.java
//   java  -cp ".;lib\*" TwilioCallTest
//
// FILL IN YOUR VALUES BELOW BEFORE RUNNING:
// ─────────────────────────────────────────────────────────────────────────────

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Call;
import com.twilio.type.PhoneNumber;
import com.twilio.type.Twiml;

public class TwilioCallTest {

    // ── ✏️  FILL THESE IN ────────────────────────────────────────────────────
    static final String ACCOUNT_SID  = "YOUR_ACCOUNT_SID";   // e.g. ACxxxxxxxxxxx
    static final String AUTH_TOKEN   = "YOUR_AUTH_TOKEN";    // from Twilio Console
    static final String FROM_PHONE   = "YOUR_TWILIO_NUMBER"; // e.g. +12345678900
    static final String TO_PHONE     = "CONTACT_PHONE";      // e.g. +919876543210
    static final String VICTIM_NAME  = "Ahamed";             // name for the message
    // ─────────────────────────────────────────────────────────────────────────

    public static void main(String[] args) {
        System.out.println("=== Twilio Call Diagnostic ===");
        System.out.println("From : " + FROM_PHONE);
        System.out.println("To   : " + TO_PHONE);
        System.out.println("Name : " + VICTIM_NAME);
        System.out.println();

        // Step 1: Validate inputs
        if (ACCOUNT_SID.startsWith("YOUR") || AUTH_TOKEN.startsWith("YOUR") ||
            FROM_PHONE.startsWith("YOUR") || TO_PHONE.startsWith("CONTACT")) {
            System.err.println("❌ ERROR: Please fill in ACCOUNT_SID, AUTH_TOKEN, FROM_PHONE, and TO_PHONE in the file before running.");
            System.exit(1);
        }

        // Step 2: Init Twilio
        System.out.println("[1] Initializing Twilio...");
        try {
            Twilio.init(ACCOUNT_SID.trim(), AUTH_TOKEN.trim());
            System.out.println("    ✅ Twilio initialized OK");
        } catch (Exception e) {
            System.err.println("    ❌ Twilio init FAILED: " + e.getMessage());
            System.err.println("    → Fix: Double check your Account SID and Auth Token from https://console.twilio.com");
            System.exit(1);
        }

        // Step 3: Build TwiML
        System.out.println("[2] Building TwiML voice message...");
        String voiceMsg = VICTIM_NAME + " is in danger. Please check WhatsApp for location and help immediately.";
        String twiml =
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
            "<Response>" +
            "<Say language=\"en-IN\" voice=\"alice\" loop=\"2\">" + voiceMsg + "</Say>" +
            "</Response>";
        System.out.println("    TwiML = " + twiml);
        System.out.println("    ✅ TwiML built OK");

        // Step 4: Place the call
        System.out.println("[3] Placing voice call...");
        try {
            Call call = Call.creator(
                new PhoneNumber(TO_PHONE.trim()),
                new PhoneNumber(FROM_PHONE.trim()),
                new Twiml(twiml)
            ).create();

            System.out.println("    ✅ CALL PLACED SUCCESSFULLY!");
            System.out.println("    SID    : " + call.getSid());
            System.out.println("    Status : " + call.getStatus());
            System.out.println("    To     : " + call.getTo());
            System.out.println("    From   : " + call.getFrom());

        } catch (com.twilio.exception.ApiException e) {
            System.err.println("    ❌ CALL FAILED — Twilio API Error:");
            System.err.println("    Code   : " + e.getCode());
            System.err.println("    Msg    : " + e.getMessage());
            System.err.println();
            diagnose(e.getCode());
        } catch (Exception e) {
            System.err.println("    ❌ CALL FAILED — Unexpected Error:");
            System.err.println("    " + e.getMessage());
        }
    }

    static void diagnose(int code) {
        System.out.println("─── DIAGNOSIS ───────────────────────────────────────");
        switch (code) {
            case 21608:
                System.out.println("⚠️  Error 21608 — TRIAL ACCOUNT RESTRICTION");
                System.out.println("   Your Twilio Trial account can ONLY call verified numbers.");
                System.out.println("   FIX: Log in to https://console.twilio.com");
                System.out.println("        → Phone Numbers → Verified Caller IDs");
                System.out.println("        → Click '+' and verify the contact's phone number: " + TO_PHONE);
                break;
            case 21211:
                System.out.println("⚠️  Error 21211 — INVALID 'TO' PHONE NUMBER");
                System.out.println("   The number \"" + TO_PHONE + "\" is not a valid E.164 number.");
                System.out.println("   FIX: The number must start with '+' and country code.");
                System.out.println("        Indian format example: +919876543210");
                break;
            case 21214:
                System.out.println("⚠️  Error 21214 — 'TO' NUMBER NOT CALLABLE");
                System.out.println("   This number cannot receive calls from Twilio.");
                System.out.println("   FIX: Check if the number is active and can receive calls.");
                break;
            case 20003:
                System.out.println("⚠️  Error 20003 — AUTHENTICATION FAILED");
                System.out.println("   Your Account SID or Auth Token is wrong.");
                System.out.println("   FIX: Re-copy them from https://console.twilio.com/dashboard");
                break;
            case 21606:
                System.out.println("⚠️  Error 21606 — FROM NUMBER NOT VALID");
                System.out.println("   The Twilio 'From' number \"" + FROM_PHONE + "\" is not a valid Twilio number.");
                System.out.println("   FIX: Copy the exact number from https://console.twilio.com → Phone Numbers");
                break;
            case 21219:
                System.out.println("⚠️  Error 21219 — FROM PHONE NOT ENABLED FOR VOICE");
                System.out.println("   Your Twilio number is not enabled for voice calls.");
                System.out.println("   FIX: In Twilio Console → Phone Numbers → your number → ensure 'Voice' is enabled.");
                break;
            default:
                System.out.println("⚠️  Unknown error code: " + code);
                System.out.println("   Search: https://www.twilio.com/docs/api/errors/" + code);
        }
        System.out.println("─────────────────────────────────────────────────────");
    }
}
