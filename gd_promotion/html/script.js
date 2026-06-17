let announcementTimeout = null;

window.addEventListener("message", (event) => {
    const { action, data } = event.data;

    if (action === "announce") {
        showAnnouncement(data);
    }
});

const showAnnouncement = (data) => {
    const container = document.getElementById("announcement-container");
    const headerText = document.getElementById("header-text");
    const businessLabel = document.getElementById("business-label");
    const messageText = document.getElementById("message-text");

    // Clear existing timeout if any
    if (announcementTimeout) {
        clearTimeout(announcementTimeout);
    }

    // Set content
    headerText.innerText = data.header || "Business Announcement";
    businessLabel.innerText = data.label;
    messageText.innerText = `"${data.message}"`;

    // Show body
    document.body.classList.remove("opacity-0");
    document.body.classList.add("opacity-100");

    // Reset container classes and show
    container.classList.remove("hidden", "animate-slide-up");
    container.classList.add("block");

    // Set timeout to hide
    announcementTimeout = setTimeout(() => {
        hideAnnouncement();
    }, data.duration || 10000);
};

const hideAnnouncement = () => {
    const container = document.getElementById("announcement-container");
    
    // Add slide up animation
    container.classList.add("animate-slide-up");

    // Fade out body
    setTimeout(() => {
        document.body.classList.remove("opacity-100");
        document.body.classList.add("opacity-0");
        
        setTimeout(() => {
            container.classList.add("hidden");
            container.classList.remove("block", "animate-slide-up");
        }, 500);
    }, 500);
};
