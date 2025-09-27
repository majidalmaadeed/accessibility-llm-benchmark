import { Component, OnInit } from '@angular/core';
import { AlertController, ModalController } from '@ionic/angular';

interface User {
  id: string;
  name: string;
  username: string;
  avatar: string;
  verified: boolean;
}

interface Post {
  id: string;
  user: User;
  content: string;
  image: string;
  location: string;
  timestamp: string;
  likes: number;
  comments: number;
  shares: number;
  isLiked: boolean;
  isBookmarked: boolean;
  privacy: string;
}

@Component({
  selector: 'app-social-media-feed',
  templateUrl: './social-media-feed.page.html',
  styleUrls: ['./social-media-feed.page.scss'],
})
export class SocialMediaFeedPage implements OnInit {
  posts: Post[] = [];
  currentFilter = 'all';
  unreadNotifications = 3;
  isLoading = false;
  showCreatePost = false;
  showPostDetails = false;
  selectedPost: Post | null = null;

  newPost = {
    content: '',
    location: '',
    privacy: 'public'
  };

  constructor(
    private alertController: AlertController,
    private modalController: ModalController
  ) {}

  ngOnInit() {
    this.loadPosts();
  }

  async loadPosts() {
    this.isLoading = true;
    
    // Simulate API call
    setTimeout(() => {
      this.posts = this.generateSamplePosts();
      this.isLoading = false;
    }, 1000);
  }

  generateSamplePosts(): Post[] {
    return [
      {
        id: '1',
        user: {
          id: 'user1',
          name: 'John Doe',
          username: '@johndoe',
          avatar: '👨‍💻',
          verified: true
        },
        content: 'Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech',
        image: '📱',
        location: 'San Francisco, CA',
        timestamp: '2h ago',
        likes: 42,
        comments: 8,
        shares: 3,
        isLiked: false,
        isBookmarked: false,
        privacy: 'public'
      },
      {
        id: '2',
        user: {
          id: 'user2',
          name: 'Sarah Wilson',
          username: '@sarahw',
          avatar: '👩‍🎨',
          verified: false
        },
        content: 'Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅',
        image: '🌅',
        location: 'New York, NY',
        timestamp: '4h ago',
        likes: 28,
        comments: 5,
        shares: 1,
        isLiked: true,
        isBookmarked: false,
        privacy: 'public'
      },
      {
        id: '3',
        user: {
          id: 'user3',
          name: 'Mike Chen',
          username: '@mikechen',
          avatar: '👨‍💼',
          verified: true
        },
        content: 'Excited to announce our new product launch! After months of hard work, we\'re finally ready to share it with the world. #Startup #Innovation',
        image: '🚀',
        location: 'Austin, TX',
        timestamp: '6h ago',
        likes: 156,
        comments: 23,
        shares: 12,
        isLiked: false,
        isBookmarked: true,
        privacy: 'public'
      },
      {
        id: '4',
        user: {
          id: 'user4',
          name: 'Emma Davis',
          username: '@emmad',
          avatar: '👩‍🔬',
          verified: false
        },
        content: 'Just read an amazing article about the future of AI in healthcare. The possibilities are endless! What are your thoughts on this?',
        image: '🤖',
        location: 'Boston, MA',
        timestamp: '8h ago',
        likes: 73,
        comments: 15,
        shares: 7,
        isLiked: true,
        isBookmarked: false,
        privacy: 'public'
      },
      {
        id: '5',
        user: {
          id: 'user5',
          name: 'Alex Rodriguez',
          username: '@alexr',
          avatar: '👨‍🎓',
          verified: false
        },
        content: 'Coffee and code - the perfect combination for a productive day! ☕️💻',
        image: '☕️',
        location: 'Seattle, WA',
        timestamp: '10h ago',
        likes: 34,
        comments: 6,
        shares: 2,
        isLiked: false,
        isBookmarked: false,
        privacy: 'public'
      }
    ];
  }

  onFilterChanged() {
    // In a real app, this would filter posts based on the selected filter
    console.log('Filter changed to:', this.currentFilter);
  }

  onCreatePostClicked() {
    this.newPost = {
      content: '',
      location: '',
      privacy: 'public'
    };
    this.showCreatePost = true;
  }

  onCreatePostDismissed() {
    this.showCreatePost = false;
  }

  async onPublishPost() {
    if (!this.newPost.content.trim()) {
      const alert = await this.alertController.create({
        header: 'Error',
        message: 'Please enter some content for your post',
        buttons: ['OK']
      });
      await alert.present();
      return;
    }

    const newPost: Post = {
      id: Date.now().toString(),
      user: {
        id: 'current-user',
        name: 'You',
        username: '@you',
        avatar: '👤',
        verified: false
      },
      content: this.newPost.content,
      image: '',
      location: this.newPost.location,
      timestamp: 'now',
      likes: 0,
      comments: 0,
      shares: 0,
      isLiked: false,
      isBookmarked: false,
      privacy: this.newPost.privacy
    };

    this.posts.unshift(newPost);
    this.showCreatePost = false;

    const alert = await this.alertController.create({
      header: 'Success',
      message: 'Post published successfully',
      buttons: ['OK']
    });
    await alert.present();
  }

  onAddImage() {
    // Handle image addition
    console.log('Add image clicked');
  }

  onAddLocation() {
    // Handle location addition
    console.log('Add location clicked');
  }

  async onNotificationsClicked() {
    const alert = await this.alertController.create({
      header: 'Notifications',
      message: `You have ${this.unreadNotifications} unread notifications`,
      buttons: ['OK']
    });
    await alert.present();
  }

  async onTrendingClicked() {
    const alert = await this.alertController.create({
      header: 'Trending Topics',
      message: 'Technology, Design, Programming, Startup, Innovation',
      buttons: ['OK']
    });
    await alert.present();
  }

  onPostMenuClicked(postId: string) {
    this.presentActionSheet('Post Options', 'Cancel', null, 'Share', 'Report', 'Hide');
  }

  onLikeClicked(postId: string) {
    const post = this.posts.find(p => p.id === postId);
    if (post) {
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
    }
  }

  onCommentClicked(postId: string) {
    const post = this.posts.find(p => p.id === postId);
    if (post) {
      this.selectedPost = post;
      this.showPostDetails = true;
    }
  }

  onShareClicked(postId: string) {
    const post = this.posts.find(p => p.id === postId);
    if (post) {
      this.presentAlert('Share Post', `Share "${post.content.substring(0, 50)}..."`);
    }
  }

  onBookmarkClicked(postId: string) {
    const post = this.posts.find(p => p.id === postId);
    if (post) {
      post.isBookmarked = !post.isBookmarked;
    }
  }

  onPostDetailsDismissed() {
    this.showPostDetails = false;
    this.selectedPost = null;
  }

  async presentActionSheet(header: string, cancelText: string, destructiveText: string | null, ...buttons: string[]) {
    const alert = await this.alertController.create({
      header: header,
      buttons: [
        ...buttons.map(text => ({ text, handler: () => console.log(text) })),
        { text: cancelText, role: 'cancel' }
      ]
    });
    await alert.present();
  }

  async presentAlert(header: string, message: string) {
    const alert = await this.alertController.create({
      header: header,
      message: message,
      buttons: ['OK']
    });
    await alert.present();
  }
}
