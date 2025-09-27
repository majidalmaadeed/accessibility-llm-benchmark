import { Component, OnInit } from '@angular/core';

interface Post {
  id: number;
  author: {
    name: string;
    avatar: string;
    verified: boolean;
  };
  content: string;
  image?: string;
  timestamp: Date;
  likes: number;
  comments: number;
  shares: number;
  isLiked: boolean;
  isBookmarked: boolean;
  commentsList: Comment[];
}

interface Comment {
  id: number;
  author: {
    name: string;
    avatar: string;
  };
  content: string;
  timestamp: Date;
  likes: number;
  isLiked: boolean;
}

interface Notification {
  id: number;
  type: 'like' | 'comment' | 'follow' | 'mention';
  message: string;
  timestamp: Date;
  read: boolean;
  user: {
    name: string;
    avatar: string;
  };
}

@Component({
  selector: 'app-social-media-feed',
  templateUrl: './social-media-feed.component.html',
  styleUrls: ['./social-media-feed.component.css']
})
export class SocialMediaFeedComponent implements OnInit {
  posts: Post[] = [
    {
      id: 1,
      author: {
        name: 'Sarah Johnson',
        avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=SJ',
        verified: true
      },
      content: 'Just finished an amazing hike in the mountains! The view was absolutely breathtaking. Nature never fails to amaze me. #hiking #nature #adventure',
      image: 'https://via.placeholder.com/500x300/8bc34a/fff?text=Mountain+View',
      timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
      likes: 42,
      comments: 8,
      shares: 3,
      isLiked: false,
      isBookmarked: false,
      commentsList: [
        {
          id: 1,
          author: {
            name: 'Mike Chen',
            avatar: 'https://via.placeholder.com/32x32/2196f3/fff?text=MC'
          },
          content: 'Looks incredible! Where is this?',
          timestamp: new Date(Date.now() - 1 * 60 * 60 * 1000),
          likes: 2,
          isLiked: false
        },
        {
          id: 2,
          author: {
            name: 'Emma Wilson',
            avatar: 'https://via.placeholder.com/32x32/ff9800/fff?text=EW'
          },
          content: 'I need to go there! 😍',
          timestamp: new Date(Date.now() - 30 * 60 * 1000),
          likes: 1,
          isLiked: true
        }
      ]
    },
    {
      id: 2,
      author: {
        name: 'Tech News Daily',
        avatar: 'https://via.placeholder.com/40x40/9c27b0/fff?text=TND',
        verified: true
      },
      content: 'Breaking: New AI breakthrough could revolutionize healthcare diagnostics. The technology shows 99.7% accuracy in early disease detection.',
      timestamp: new Date(Date.now() - 4 * 60 * 60 * 1000),
      likes: 156,
      comments: 23,
      shares: 45,
      isLiked: true,
      isBookmarked: true,
      commentsList: []
    },
    {
      id: 3,
      author: {
        name: 'Alex Rodriguez',
        avatar: 'https://via.placeholder.com/40x40/f44336/fff?text=AR',
        verified: false
      },
      content: 'Coffee and code - the perfect combination for a productive day! ☕️💻',
      image: 'https://via.placeholder.com/500x300/795548/fff?text=Coffee+Setup',
      timestamp: new Date(Date.now() - 6 * 60 * 60 * 1000),
      likes: 28,
      comments: 5,
      shares: 2,
      isLiked: false,
      isBookmarked: false,
      commentsList: []
    }
  ];

  notifications: Notification[] = [
    {
      id: 1,
      type: 'like',
      message: 'liked your post',
      timestamp: new Date(Date.now() - 10 * 60 * 1000),
      read: false,
      user: {
        name: 'John Doe',
        avatar: 'https://via.placeholder.com/32x32/4caf50/fff?text=JD'
      }
    },
    {
      id: 2,
      type: 'comment',
      message: 'commented on your post',
      timestamp: new Date(Date.now() - 30 * 60 * 1000),
      read: false,
      user: {
        name: 'Jane Smith',
        avatar: 'https://via.placeholder.com/32x32/2196f3/fff?text=JS'
      }
    },
    {
      id: 3,
      type: 'follow',
      message: 'started following you',
      timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
      read: true,
      user: {
        name: 'Bob Wilson',
        avatar: 'https://via.placeholder.com/32x32/ff9800/fff?text=BW'
      }
    }
  ];

  newPostContent: string = '';
  showComposer: boolean = false;
  showNotifications: boolean = false;
  showComments: { [key: number]: boolean } = {};
  newComment: { [key: number]: string } = {};
  isLoading: boolean = false;
  currentUser = {
    name: 'You',
    avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=ME'
  };

  constructor() { }

  ngOnInit(): void {
    this.loadMorePosts();
  }

  async loadMorePosts(): Promise<void> {
    this.isLoading = true;
    
    setTimeout(() => {
      // Simulate loading more posts
      this.isLoading = false;
    }, 1000);
  }

  handleLike(postId: number): void {
    const post = this.posts.find(p => p.id === postId);
    if (post) {
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
    }
  }

  handleBookmark(postId: number): void {
    const post = this.posts.find(p => p.id === postId);
    if (post) {
      post.isBookmarked = !post.isBookmarked;
    }
  }

  handleShare(postId: number): void {
    const post = this.posts.find(p => p.id === postId);
    if (post) {
      post.shares += 1;
      alert('Post shared successfully!');
    }
  }

  handleComment(postId: number): void {
    this.showComments[postId] = !this.showComments[postId];
  }

  handleAddComment(postId: number): void {
    const commentText = this.newComment[postId];
    if (!commentText?.trim()) return;

    const post = this.posts.find(p => p.id === postId);
    if (post) {
      const newComment: Comment = {
        id: Date.now(),
        author: this.currentUser,
        content: commentText,
        timestamp: new Date(),
        likes: 0,
        isLiked: false
      };
      post.commentsList.push(newComment);
      post.comments += 1;
      this.newComment[postId] = '';
    }
  }

  handleLikeComment(postId: number, commentId: number): void {
    const post = this.posts.find(p => p.id === postId);
    if (post) {
      const comment = post.commentsList.find(c => c.id === commentId);
      if (comment) {
        comment.isLiked = !comment.isLiked;
        comment.likes += comment.isLiked ? 1 : -1;
      }
    }
  }

  handleCreatePost(): void {
    if (!this.newPostContent.trim()) return;

    const newPost: Post = {
      id: Date.now(),
      author: this.currentUser,
      content: this.newPostContent,
      timestamp: new Date(),
      likes: 0,
      comments: 0,
      shares: 0,
      isLiked: false,
      isBookmarked: false,
      commentsList: []
    };

    this.posts.unshift(newPost);
    this.newPostContent = '';
    this.showComposer = false;
  }

  handleNotificationClick(notification: Notification): void {
    notification.read = true;
  }

  markAllNotificationsRead(): void {
    this.notifications.forEach(notification => notification.read = true);
  }

  getUnreadNotificationCount(): number {
    return this.notifications.filter(n => !n.read).length;
  }

  formatTimestamp(timestamp: Date): string {
    const now = new Date();
    const diff = now.getTime() - timestamp.getTime();
    const minutes = Math.floor(diff / (1000 * 60));
    const hours = Math.floor(diff / (1000 * 60 * 60));
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));

    if (minutes < 1) return 'now';
    if (minutes < 60) return `${minutes}m`;
    if (hours < 24) return `${hours}h`;
    if (days < 7) return `${days}d`;
    return timestamp.toLocaleDateString();
  }

  getNotificationIcon(type: string): string {
    switch (type) {
      case 'like': return '❤️';
      case 'comment': return '💬';
      case 'follow': return '👤';
      case 'mention': return '@';
      default: return '🔔';
    }
  }

  onScroll(event: Event): void {
    const element = event.target as HTMLElement;
    if (element.scrollTop + element.clientHeight >= element.scrollHeight - 100) {
      this.loadMorePosts();
    }
  }
}
