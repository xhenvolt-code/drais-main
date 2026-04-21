import fetch from "node-fetch";
import cron from "node-cron";

const API_URL = "http://localhost:3000/api/result-deadlines";

// Schedule the cron job
cron.schedule("0 8,12,17 * * *", async () => {
  try {
    const response = await fetch(API_URL);
    const result = await response.json();
    console.log("Reminder job executed:", result);
  } catch (error) {
    console.error("Error executing reminder job:", error.message);
  }
});
