namespace UIComponents.Views;

public partial class MediaPlayerPage : ContentPage
{
    private bool isPlaying = false;

    public MediaPlayerPage()
    {
        InitializeComponent();
    }

    private void OnPlayPauseClicked(object sender, EventArgs e)
    {
        isPlaying = !isPlaying;
        NowPlayingLabel.Text = isPlaying ? "Playing: Sample Media" : "Paused: Sample Media";
    }

    private void OnStopClicked(object sender, EventArgs e)
    {
        isPlaying = false;
        NowPlayingLabel.Text = "Stopped";
        ProgressBar.Progress = 0;
    }

    private void OnPreviousClicked(object sender, EventArgs e)
    {
        DisplayAlert("Media Player", "Previous track", "OK");
    }

    private void OnNextClicked(object sender, EventArgs e)
    {
        DisplayAlert("Media Player", "Next track", "OK");
    }

    private void OnShuffleClicked(object sender, EventArgs e)
    {
        DisplayAlert("Media Player", "Shuffle toggled", "OK");
    }

    private void OnVolumeChanged(object sender, ValueChangedEventArgs e)
    {
        VolumeLabel.Text = $"Volume: {(int)e.NewValue}%";
    }
}
