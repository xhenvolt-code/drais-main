import { NextRequest, NextResponse } from "next/server";
import { getConnection } from "@/lib/db";
import AfricasTalking from "africastalking";

const africasTalkingClient = AfricasTalking({
  apiKey: "atsk_3baf21e161cca165c4f5ccb67bc38f5a50a192e3208fafc3b575014f35793d9a1994a774",
  username: "xhenovolt",
});

const sms = africasTalkingClient.SMS;

async function formatPhoneNumber(contact: string): Promise<string> {
  if (/^0\d{9}$/.test(contact)) {
    return "+256" + contact.substring(1);
  } else if (/^256\d{9}$/.test(contact)) {
    return "+" + contact;
  } else if (contact.startsWith("+256") && contact.length === 13) {
    return contact;
  } else {
    return contact.startsWith("+") ? contact : "+" + contact;
  }
}

export async function POST(req: NextRequest) {
  const body = await req.json();
  const memberCode = body.member_code;
  const message = body.message;

  if (!memberCode || !message) {
    return NextResponse.json(
      { error: "Missing member_code or message." },
      { status: 400 }
    );
  }

  try {
    const connection = await getConnection();
    const [rows] = await connection.execute(
      "SELECT contact FROM members WHERE member_code = ?",
      [memberCode]
    );
    await connection.end();

    if (!rows || rows.length === 0 || !rows[0].contact) {
      return NextResponse.json(
        { error: "Member contact not found." },
        { status: 404 }
      );
    }

    const contact = rows[0].contact;
    const formattedContact = await formatPhoneNumber(contact);

    try {
      const response = await sms.send({
        to: +256,
        message,
        // from: "INFO", // Optional sender ID if configured
      });

      const recipients = response.SMSMessageData?.Recipients || [];
      if (recipients.length > 0 && recipients[0].status === "Success") {
        const firstRecipient = recipients[0];
        return NextResponse.json({
          success: true,
          message: "SMS sent successfully",
          status: firstRecipient.status,
          messageId: firstRecipient.messageId,
          cost: firstRecipient.cost,
        });
      } else {
        throw new Error(
          `SMS failed with status: ${recipients[0]?.status || "Unknown"}`
        );
      }
    } catch (error: any) {
      console.error("Error sending SMS:", error.message);
      return NextResponse.json(
        { error: `SMS failed: ${error.message}` },
        { status: 500 }
      );
    }
  } catch (error: any) {
    console.error("Error processing request:", error.message);
    return NextResponse.json(
      { error: `Failed to process request: ${error.message}` },
      { status: 500 }
    );
  }
}

export async function GET() {
  const to = "+256741341483"; // Hardcoded test number
  const message = "This is a test message from the SMS API.";

  try {
    const response = await sms.send({
      to: [to],
      message,
    //    from: "XHENVOLT UG", // Replace with your sender ID or short code
    });

    const recipients = response.SMSMessageData?.Recipients || [];
    if (recipients.length > 0 && recipients[0].status === "Success") {
      const firstRecipient = recipients[0];
      return NextResponse.json({
        success: true,
        message: "SMS sent successfully",
        status: firstRecipient.status,
        messageId: firstRecipient.messageId,
        cost: firstRecipient.cost,
      });
    } else {
      throw new Error(
        `SMS failed with status: ${recipients[0]?.status || "Unknown"}`
      );
    }
  } catch (error: any) {
    console.error("Error sending SMS:", error.message);
    return NextResponse.json(
      { error: `SMS failed: ${error.message}` },
      { status: 500 }
    );
  }
}
