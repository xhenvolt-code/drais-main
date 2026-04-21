import { NextRequest, NextResponse } from "next/server";
import { getConnection } from "@/lib/db";
import AfricasTalking from "africastalking";

const africasTalkingClient = AfricasTalking({
  apiKey: "atsk_3baf21e161cca165c4f5ccb67bc38f5a50a192e3208fafc3b575014f35793d9a1994a774",
  username: "xhenovolt",
});

const sms = africasTalkingClient.SMS;

async function sendSMS(to: string, message: string) {
  const options = {
    to: [to],
    message,
    from: "XHENVOLT UG", // Replace with your sender ID or short code
  };

  try {
    const response = await sms.send(options);
    const recipients = response.SMSMessageData?.Recipients || [];
    if (recipients.length > 0 && recipients[0].status === "Success") {
      return {
        success: true,
        status: recipients[0].status,
        messageId: recipients[0].messageId,
        cost: recipients[0].cost,
      };
    } else {
      throw new Error(`SMS failed with status: ${recipients[0]?.status || "Unknown"}`);
    }
  } catch (error) {
    console.error("Error sending SMS:", error);
    throw new Error("Failed to send SMS. Please try again later.");
  }
}

export async function GET(req: NextRequest) {
  const now = new Date();
  const currentTime = now.toTimeString().split(" ")[0]; // Get current time in HH:MM:SS format
  const today = now.toISOString().split("T")[0]; // Get today's date in YYYY-MM-DD format

  try {
    const connection = await getConnection();

    // Fetch deadlines that are tomorrow or the day after tomorrow
    const [deadlines] = await connection.execute(
      `SELECT d.id, d.exam_id, d.teacher_id, d.deadline, d.reminder_days_before, r.reminder_time
       FROM result_submission_deadlines d
       JOIN reminder_schedule r ON d.id = r.deadline_id
       WHERE DATE(d.deadline) IN (DATE_ADD(CURDATE(), INTERVAL 1 DAY), DATE_ADD(CURDATE(), INTERVAL 2 DAY))
       AND r.reminder_time = ?`,
      [currentTime]
    );

    // Send SMS reminders for each deadline
    for (const deadline of deadlines) {
      const teacherId = deadline.teacher_id;
      const [teacher] = await connection.execute(
        "SELECT phone FROM staff WHERE id = ?",
        [teacherId]
      );

      if (teacher.length > 0 && teacher[0].phone) {
        const phone = teacher[0].phone;
        const message = `Reminder: Results for Exam ID ${deadline.exam_id} are due on ${new Date(
          deadline.deadline
        ).toLocaleString()}. Please submit them on time.`;

        try {
          await sendSMS(phone, message);
          console.log(`SMS sent to ${phone} for deadline ID ${deadline.id}`);
        } catch (error) {
          console.error(`Failed to send SMS to ${phone}:`, error.message);
        }
      }
    }

    await connection.end();
    return NextResponse.json({ success: true, message: "Reminders processed successfully." });
  } catch (error: any) {
    console.error("Error processing reminders:", error.message);
    return NextResponse.json(
      { error: "Failed to process reminders. Please try again later." },
      { status: 500 }
    );
  }
}
