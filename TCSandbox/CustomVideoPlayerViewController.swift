import UIKit
import AVFoundation

private var playbackLikelyToKeepUpContext = 0

class CustomVideoPlayerViewController: UIViewController {
    var avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    let invisibleButton = UIButton()
    var timeObserver: AnyObject!
    let timeRemainingLabel = UILabel()
    let loadingIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    var videoURL: NSURL?
    let seekSlider = UISlider()
    var playerRateBeforeSeek: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackColor()
        seekSlider.thumbTintColor = UIColor(hex: 0x57C3BB)
        seekSlider.minimumTrackTintColor = UIColor(hex: 0x57C3BB)
        
        // An AVPlayerLayer is a CALayer instance to which the AVPlayer can
        // direct its visual output. Without it, the user will see nothing.
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        view.layer.insertSublayer(avPlayerLayer, atIndex: 0)
        
        let playerItem = AVPlayerItem(URL: videoURL!)
        avPlayer.replaceCurrentItemWithPlayerItem(playerItem)
        
        view.addSubview(invisibleButton)
        invisibleButton.addTarget(self, action: #selector(invisibleButtonTapped),
                                  forControlEvents: .TouchUpInside)
        
        let timeInterval: CMTime = CMTimeMakeWithSeconds(0.01, 100)
        timeObserver = avPlayer.addPeriodicTimeObserverForInterval(timeInterval,
                                                                   queue: dispatch_get_main_queue()) { (elapsedTime: CMTime) -> Void in
                                                                    
                                                                    // print("elapsedTime now:", CMTimeGetSeconds(elapsedTime))
                                                                    self.observeTime(elapsedTime)
        }
        timeRemainingLabel.textColor = .whiteColor()
        view.addSubview(timeRemainingLabel)
        
        view.addSubview(seekSlider)
        seekSlider.addTarget(self, action: #selector(sliderBeganTracking),
                             forControlEvents: .TouchDown)
        seekSlider.addTarget(self, action: #selector(sliderEndedTracking),
                             forControlEvents: [.TouchUpInside, .TouchUpOutside])
        seekSlider.addTarget(self, action: #selector(sliderValueChanged),
                             forControlEvents: .ValueChanged)
        
        loadingIndicatorView.hidesWhenStopped = true
        view.addSubview(loadingIndicatorView)
        avPlayer.addObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp",
                             options: .New, context: &playbackLikelyToKeepUpContext)
    }
    
    func setVideo(url: NSURL) {
        let playerItem = AVPlayerItem(URL: url)
        videoURL = url
        avPlayer.replaceCurrentItemWithPlayerItem(playerItem)
    }
    
    deinit {
        avPlayer.removeTimeObserver(timeObserver)
        avPlayer.removeObserver(self, forKeyPath: "currentItem.playbackLikelyToKeepUp")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?,
                                         change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if context == &playbackLikelyToKeepUpContext {
            if avPlayer.currentItem!.playbackLikelyToKeepUp {
                loadingIndicatorView.stopAnimating()
            } else {
                loadingIndicatorView.startAnimating()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadingIndicatorView.startAnimating()
        avPlayer.play() // Start the playback
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Layout subviews manually
        avPlayerLayer.frame = view.bounds
        invisibleButton.frame = view.bounds
        let controlsHeight: CGFloat = 50
        let controlsY: CGFloat = view.bounds.size.height - controlsHeight
        timeRemainingLabel.frame = CGRect(x: view.bounds.size.width - 60, y: controlsY, width: 60, height: controlsHeight)
        seekSlider.frame = CGRect(x: 15,
                                  y: controlsY, width: view.bounds.size.width - timeRemainingLabel.bounds.size.width - 35, height: controlsHeight)
        loadingIndicatorView.center = CGPoint(x: CGRectGetMidX(view.bounds), y: CGRectGetMidY(view.bounds))

    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func invisibleButtonTapped(sender: UIButton) {
        let playerIsPlaying = avPlayer.rate > 0
        if playerIsPlaying {
            avPlayer.pause()
        } else {
            avPlayer.play()
        }
    }
    
    func updateSeekerSlider(elapsedTime: Float64, duration: Float64) {
        seekSlider.value = Float(elapsedTime / duration)
    }
    
    func sliderBeganTracking(slider: UISlider) {
        playerRateBeforeSeek = avPlayer.rate
        avPlayer.pause()
    }
    
    func sliderEndedTracking(slider: UISlider) {
        let videoDuration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        let elapsedTime: Float64 = videoDuration * Float64(seekSlider.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
        
        avPlayer.seekToTime(CMTimeMakeWithSeconds(elapsedTime, 100)) { (completed: Bool) -> Void in
            if self.playerRateBeforeSeek > 0 {
                self.avPlayer.play()
            }
        }
    }
    
    func sliderValueChanged(slider: UISlider) {
        let videoDuration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        let elapsedTime: Float64 = videoDuration * Float64(seekSlider.value)
        updateTimeLabel(elapsedTime: elapsedTime, duration: videoDuration)
    }
    
    private func updateTimeLabel(elapsedTime elapsedTime: Float64, duration: Float64) {
        let timeRemaining: Float64 = CMTimeGetSeconds(avPlayer.currentItem!.duration) - elapsedTime
        timeRemainingLabel.text = String(format: "%02d:%02d", ((lround(timeRemaining) / 60) % 60), lround(timeRemaining) % 60)
    }
    
    private func observeTime(elapsedTime: CMTime) {
        let duration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        if isfinite(duration) {
            let elapsedTime = CMTimeGetSeconds(elapsedTime)
            updateTimeLabel(elapsedTime: elapsedTime, duration: duration)
            updateSeekerSlider(elapsedTime, duration: duration)
        }
    }
    
    func stopVideo()
    {
        avPlayer.pause()
    }
    
    // Force the view into landscape mode (which is how most video media is consumed.)
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
}