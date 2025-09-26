import { Component, OnInit, ViewChild, ElementRef, OnDestroy } from '@angular/core';

@Component({
  selector: 'app-media-player-full-interface',
  templateUrl: './media-player-full-interface.component.html',
  styleUrls: ['./media-player-full-interface.component.css']
})
export class MediaPlayerFullInterfaceComponent implements OnInit, OnDestroy {
  @ViewChild('videoRef', { static: false }) videoRef!: ElementRef<HTMLVideoElement>;

  isPlaying: boolean = false;
  currentTime: number = 0;
  duration: number = 0;
  volume: number = 1;
  isMuted: boolean = false;
  playbackRate: number = 1;
  isFullscreen: boolean = false;
  showCaptions: boolean = false;
  showQualityMenu: boolean = false;
  showSettingsMenu: boolean = false;
  selectedQuality: string = '1080p';
  selectedCaption: string = 'English';
  showControls: boolean = true;
  isLoading: boolean = false;

  qualityOptions: string[] = ['360p', '480p', '720p', '1080p', '4K'];
  captionOptions: string[] = ['English', 'Spanish', 'French', 'German', 'Off'];
  playbackRates: number[] = [0.5, 0.75, 1, 1.25, 1.5, 2];

  private videoElement: HTMLVideoElement | null = null;

  constructor() { }

  ngOnInit(): void {
    // Initialize video element after view init
    setTimeout(() => {
      this.setupVideoListeners();
    }, 0);
  }

  ngOnDestroy(): void {
    this.removeVideoListeners();
  }

  ngAfterViewInit(): void {
    this.videoElement = this.videoRef?.nativeElement;
    this.setupVideoListeners();
  }

  private setupVideoListeners(): void {
    if (!this.videoElement) return;

    this.videoElement.addEventListener('timeupdate', this.handleTimeUpdate.bind(this));
    this.videoElement.addEventListener('durationchange', this.handleDurationChange.bind(this));
    this.videoElement.addEventListener('loadstart', this.handleLoadStart.bind(this));
    this.videoElement.addEventListener('canplay', this.handleCanPlay.bind(this));
    this.videoElement.addEventListener('play', this.handlePlay.bind(this));
    this.videoElement.addEventListener('pause', this.handlePause.bind(this));
  }

  private removeVideoListeners(): void {
    if (!this.videoElement) return;

    this.videoElement.removeEventListener('timeupdate', this.handleTimeUpdate.bind(this));
    this.videoElement.removeEventListener('durationchange', this.handleDurationChange.bind(this));
    this.videoElement.removeEventListener('loadstart', this.handleLoadStart.bind(this));
    this.videoElement.removeEventListener('canplay', this.handleCanPlay.bind(this));
    this.videoElement.removeEventListener('play', this.handlePlay.bind(this));
    this.videoElement.removeEventListener('pause', this.handlePause.bind(this));
  }

  private handleTimeUpdate(): void {
    if (this.videoElement) {
      this.currentTime = this.videoElement.currentTime;
    }
  }

  private handleDurationChange(): void {
    if (this.videoElement) {
      this.duration = this.videoElement.duration;
    }
  }

  private handleLoadStart(): void {
    this.isLoading = true;
  }

  private handleCanPlay(): void {
    this.isLoading = false;
  }

  private handlePlay(): void {
    this.isPlaying = true;
  }

  private handlePause(): void {
    this.isPlaying = false;
  }

  togglePlay(): void {
    if (!this.videoElement) return;

    if (this.isPlaying) {
      this.videoElement.pause();
    } else {
      this.videoElement.play();
    }
  }

  handleSeek(event: MouseEvent): void {
    if (!this.videoElement) return;

    const target = event.currentTarget as HTMLElement;
    const rect = target.getBoundingClientRect();
    const clickX = event.clientX - rect.left;
    const newTime = (clickX / rect.width) * this.duration;
    this.videoElement.currentTime = newTime;
    this.currentTime = newTime;
  }

  handleVolumeChange(event: Event): void {
    if (!this.videoElement) return;

    const target = event.target as HTMLInputElement;
    const newVolume = parseFloat(target.value);
    this.videoElement.volume = newVolume;
    this.volume = newVolume;
    this.isMuted = newVolume === 0;
  }

  toggleMute(): void {
    if (!this.videoElement) return;

    if (this.isMuted) {
      this.videoElement.volume = this.volume;
      this.isMuted = false;
    } else {
      this.videoElement.volume = 0;
      this.isMuted = true;
    }
  }

  changePlaybackRate(rate: number): void {
    if (!this.videoElement) return;

    this.videoElement.playbackRate = rate;
    this.playbackRate = rate;
  }

  toggleFullscreen(): void {
    if (!document.fullscreenElement) {
      this.videoElement?.requestFullscreen();
      this.isFullscreen = true;
    } else {
      document.exitFullscreen();
      this.isFullscreen = false;
    }
  }

  formatTime(time: number): string {
    const minutes = Math.floor(time / 60);
    const seconds = Math.floor(time % 60);
    return `${minutes}:${seconds.toString().padStart(2, '0')}`;
  }

  handleQualityChange(quality: string): void {
    this.selectedQuality = quality;
    this.showQualityMenu = false;
    console.log(`Quality changed to ${quality}`);
  }

  handleCaptionChange(caption: string): void {
    this.selectedCaption = caption;
    this.showCaptions = caption !== 'Off';
    console.log(`Captions changed to ${caption}`);
  }

  onMouseMove(): void {
    this.showControls = true;
  }

  onMouseLeave(): void {
    this.showControls = false;
  }

  getVolumeIcon(): string {
    if (this.isMuted) return '🔇';
    if (this.volume > 0.5) return '🔊';
    return '🔉';
  }

  getPlayIcon(): string {
    return this.isPlaying ? '⏸️' : '▶️';
  }

  getFullscreenIcon(): string {
    return this.isFullscreen ? '⤢' : '⤡';
  }
}
