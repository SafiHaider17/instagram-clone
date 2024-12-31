import consumer from "./consumer"

const likeChannel = consumer.subscriptions.create(
  { channel: "LikeChannel", post_id: "post_id" }, // Replace with actual post_id
  {
    received(data) {
      // Update the like count in real-time when a like/unlike occurs
      const likeCountElement = document.getElementById('like-count');
      likeCountElement.innerText = data.like_count; // Update the like count displayed
    }
  }
);
