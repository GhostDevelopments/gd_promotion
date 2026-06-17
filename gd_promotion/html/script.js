let announcementTimeout = null;
let hideTimeout1 = null;
let hideTimeout2 = null;

window.addEventListener("message", (event) => {
  const { action, data } = event.data;

  if (action === "announce") {
    showAnnouncement(data);
  }
});

const showAnnouncement = (data) => {
  const container = document.getElementById("announcement-container");
  const businessLabel = document.getElementById("business-label");
  const jobLabel = document.getElementById("job-label");
  const senderName = document.getElementById("sender-name");
  const messageText = document.getElementById("message-text");

  // Clear all existing timeouts to prevent race conditions
  if (announcementTimeout) clearTimeout(announcementTimeout);
  if (hideTimeout1) clearTimeout(hideTimeout1);
  if (hideTimeout2) clearTimeout(hideTimeout2);

  // Set content
  businessLabel.innerText = data.label;
  jobLabel.innerText = data.label;
  senderName.innerText = data.sender;
  messageText.innerText = data.message;

  // Ensure container is visible and reset animations
  container.classList.remove("hidden", "animate-slide-up", "opacity-0");
  container.classList.add("block", "opacity-100");

  // Set timeout to hide
  announcementTimeout = setTimeout(() => {
    hideAnnouncement();
  }, data.duration || 10000);
};

const hideAnnouncement = () => {
  const container = document.getElementById("announcement-container");
  
  // 1. Start slide up animation
  container.classList.add("animate-slide-up");

  // 2. Fade out container after slide starts
  hideTimeout1 = setTimeout(() => {
    container.classList.replace("opacity-100", "opacity-0");
    
    // 3. Fully hide once transitions are done
    hideTimeout2 = setTimeout(() => {
      container.classList.add("hidden");
      container.classList.remove("block", "animate-slide-up");
    }, 500);
  }, 300);
};
