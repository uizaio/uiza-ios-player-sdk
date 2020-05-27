//
//  UZDefaultTheme.swift
//  UZPlayer
//
//  Created by Nam Nguyễn on 5/27/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import UIKit
import FrameLayoutKit
import AVKit

open class UZDefaultTheme: UZPlayerTheme {
	public var id = "UZDefaultTheme"
	public weak var controlView: UZPlayerControlView?
	
	public let topGradientLayer = CAGradientLayer()
	public let bottomGradientLayer = CAGradientLayer()
	
	public let frameLayout = StackFrameLayout(axis: .vertical, distribution: . top)
	
	open var iconColor = UIColor.white
	open var iconSize = CGSize(width: 24, height: 24)
	open var skipIconSize = CGSize(width: 32, height: 32)
	open var centerIconSize = CGSize(width: 92, height: 92)
	open var seekThumbSize = CGSize(width: 24, height: 24)
	open var buttonMinSize = CGSize(width: 32, height: 32)
	
	public convenience init(iconSize: CGSize = CGSize(width: 24, height: 24), centerIconSize: CGSize = CGSize(width: 92, height: 92), seekThumbSize: CGSize = CGSize(width: 24, height: 24), iconColor: UIColor = .white) {
		self.init()
		
		self.iconSize = iconSize
		self.centerIconSize = centerIconSize
		self.iconColor = iconColor
		self.seekThumbSize = seekThumbSize
	}
	
	public init() {
		
	}
	
	open func updateUI() {
		setupSkin()
		setupLayout()
	}
	
	func setupSkin() {
		guard let controlView = controlView else { return }
		
		let bundlePath = Bundle.main.path(forResource: "UZDefaultThemeIcons", ofType: "bundle")
		let imageBundle = Bundle(path: bundlePath ?? "")
		
		let backIcon = UIImage(named: "ic_close", in: imageBundle, compatibleWith: nil)
		let playlistIcon = UIImage(icon: .fontAwesomeSolid(.list), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let helpIcon = UIImage(icon: .fontAwesomeSolid(.questionCircle), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let ccIcon = UIImage(icon: .icofont(.cc), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let settingsIcon = UIImage(named: "ic_settings", in: imageBundle, compatibleWith: nil)
		let volumeIcon = UIImage(icon: .fontAwesomeSolid(.volumeUp), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let muteIcon = UIImage(icon: .icofont(.volumeMute), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let playBigIcon = UIImage(icon: .fontAwesomeSolid(.playCircle), size: centerIconSize, textColor: iconColor, backgroundColor: .clear)
		let pauseBigIcon = UIImage(named: "ic_pause_big", in: imageBundle, compatibleWith: nil)
		let playIcon = UIImage(icon: .googleMaterialDesign(.playArrow), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let pauseIcon = UIImage(icon: .googleMaterialDesign(.pause), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let forwardIcon = UIImage(icon: .fontAwesomeSolid(.forward), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let backwardIcon = UIImage(icon: .fontAwesomeSolid(.backward), size: iconSize, textColor: iconColor, backgroundColor: .clear)
		let nextIcon = UIImage(icon: .fontAwesomeSolid(.stepForward), size: skipIconSize, textColor: iconColor, backgroundColor: .clear)
		let previousIcon = UIImage(icon: .fontAwesomeSolid(.stepBackward), size: skipIconSize, textColor: iconColor, backgroundColor: .clear)
		let fullscreenIcon = UIImage(named: "ic_fullscreen", in: imageBundle, compatibleWith: nil)
		let collapseIcon = UIImage(named: "ic_exit_fullscreen", in: imageBundle, compatibleWith: nil)
		let thumbIcon = UIImage(named: "ic_thumb", in: imageBundle, compatibleWith: nil)
		
		controlView.backButton.setImage(backIcon, for: .normal)
		controlView.playlistButton.setImage(playlistIcon, for: .normal)
		controlView.helpButton.setImage(helpIcon, for: .normal)
		controlView.ccButton.setImage(ccIcon, for: .normal)
		controlView.settingsButton.setImage(settingsIcon, for: .normal)
		controlView.volumeButton.setImage(volumeIcon, for: .normal)
		controlView.volumeButton.setImage(muteIcon, for: .selected)
		controlView.playpauseCenterButton.setImage(playBigIcon, for: .normal)
		controlView.playpauseCenterButton.setImage(pauseBigIcon, for: .selected)
		controlView.playpauseButton.setImage(playIcon, for: .normal)
		controlView.playpauseButton.setImage(pauseIcon, for: .selected)
		controlView.forwardButton.setImage(forwardIcon, for: .normal)
		controlView.backwardButton.setImage(backwardIcon, for: .normal)
		controlView.nextButton.setImage(nextIcon, for: .normal)
		controlView.previousButton.setImage(previousIcon, for: .normal)
		controlView.fullscreenButton.setImage(fullscreenIcon, for: .normal)
		controlView.fullscreenButton.setImage(collapseIcon, for: .selected)
		controlView.timeSlider.setThumbImage(thumbIcon, for: .normal)
		controlView.timeSlider.tintColor = .red
		
		controlView.liveBadgeView.liveBadge.titles[.normal] = "Live"
		controlView.liveBadgeView.liveBadge.titleFonts[.normal] = UIFont(name: "Avenir", size: 9)
		controlView.liveBadgeView.liveBadge.titleColors[.normal] = UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1.0)
		controlView.liveBadgeView.liveBadge.images[.normal] = UIImage(named: "ic_live_dot", in: imageBundle, compatibleWith: nil)
		controlView.liveBadgeView.liveBadge.backgroundColors[.normal] = .clear
		controlView.liveBadgeView.liveBadge.spacing = 4.0
		
		controlView.liveBadgeView.viewBadge.images[.normal] = UIImage(named: "ic_view", in: imageBundle, compatibleWith: nil)
		controlView.liveBadgeView.viewBadge.titleFonts[.normal] = UIFont(name: "Avenir", size: 9)
		controlView.liveBadgeView.viewBadge.backgroundColors[.normal] = UIColor.black.withAlphaComponent(0.2)
		controlView.liveBadgeView.viewBadge.spacing = 6.0
		
		controlView.nextButton.isHidden = true
		controlView.previousButton.isHidden = true
		
		if #available(iOS 9.0, *) {
			let pipStartIcon = AVPictureInPictureController.pictureInPictureButtonStartImage(compatibleWith: nil).colorize(with: iconColor)
			let pipStopIcon = AVPictureInPictureController.pictureInPictureButtonStopImage(compatibleWith: nil).colorize(with: iconColor)
			controlView.pipButton.setImage(pipStartIcon, for: .normal)
			controlView.pipButton.setImage(pipStopIcon, for: .selected)
			controlView.pipButton.imageView?.contentMode = .scaleAspectFit
			controlView.pipButton.isHidden = !AVPictureInPictureController.isPictureInPictureSupported()
		} else {
			// Fallback on earlier versions
		}
		
//		controlView.airplayButton.setupDefaultIcon(iconSize: iconSize, offColor: iconColor)
		controlView.castingButton.setupDefaultIcon(iconSize: iconSize, offColor: iconColor)
		
		controlView.titleLabel.textColor = .white
		controlView.titleLabel.font = UIFont.systemFont(ofSize: 14)
		
		let timeLabelFont = UIFont(name: "Avenir", size: 12)
		let timeLabelColor = UIColor.white
		let timeLabelShadowColor = UIColor.black
		let timeLabelShadowOffset = CGSize(width: 0, height: 1)
		
		controlView.currentTimeLabel.textColor = timeLabelColor
		controlView.currentTimeLabel.font = timeLabelFont
		controlView.currentTimeLabel.shadowColor = timeLabelShadowColor
		controlView.currentTimeLabel.shadowOffset = timeLabelShadowOffset
		
		controlView.totalTimeLabel.textColor = timeLabelColor
		controlView.totalTimeLabel.font = timeLabelFont
		controlView.totalTimeLabel.shadowColor = timeLabelShadowColor
		controlView.totalTimeLabel.shadowOffset = timeLabelShadowOffset
		
		controlView.remainTimeLabel.textColor = timeLabelColor
		controlView.remainTimeLabel.font = timeLabelFont
		controlView.remainTimeLabel.shadowColor = timeLabelShadowColor
		controlView.remainTimeLabel.shadowOffset = timeLabelShadowOffset
	}
	
	func setupLayout() {
		guard let controlView = controlView else { return }
		
		controlView.allControlViews.forEach { (view) in
			frameLayout.addSubview(view)
		}
		
		frameLayout.isUserInteractionEnabled = true
		topGradientLayer.colors = [UIColor(white: 0.0, alpha: 0.8).cgColor, UIColor(white: 0.0, alpha: 0.0).cgColor]
		bottomGradientLayer.colors = [UIColor(white: 0.0, alpha: 0.0).cgColor, UIColor(white: 0.0, alpha: 0.8).cgColor]
		controlView.containerView.layer.addSublayer(topGradientLayer)
		controlView.containerView.layer.addSublayer(bottomGradientLayer)
		
		frameLayout + HStackLayout {
			$0 + [controlView.backButton, controlView.titleLabel]
			($0 + 0).flexible()
			$0 + [controlView.pipButton, controlView.castingButton, controlView.playlistButton, controlView.settingsButton, controlView.volumeButton]
			$0.spacing = 10
		}
		frameLayout + HStackLayout {
			($0 + [controlView.previousButton, controlView.playpauseCenterButton, controlView.nextButton]).forEach { (layout) in
				layout.alignment = (.center, .center)
			}
			$0.spacing = 10
			$0.alignment = (.center, .center)
			$0.distribution = .center
			$0.flexible()
		}
		frameLayout + HStackLayout {
			$0 + controlView.currentTimeLabel
			($0 + controlView.timeSlider).flexible()
			$0 + [controlView.remainTimeLabel, controlView.backwardButton, controlView.forwardButton, controlView.fullscreenButton]
			$0.spacing = 10
		}
		frameLayout.padding(top: 10, left: 10, bottom: 0, right: 10)
		controlView.containerView.addSubview(frameLayout)
	}
	
	open func layoutControls(rect: CGRect) {
		frameLayout.frame = rect
		frameLayout.layoutIfNeeded()
		
		controlView?.loadingIndicatorView?.center = controlView?.center ?? .zero
		
		CATransaction.begin()
		CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
		topGradientLayer.frame = frameLayout.firstFrameLayout?.frame.inset(by: UIEdgeInsets(top: -frameLayout.edgeInsets.top, left: -frameLayout.edgeInsets.left, bottom: -frameLayout.edgeInsets.bottom, right: -frameLayout.edgeInsets.right)) ?? .zero
		bottomGradientLayer.frame = frameLayout.lastFrameLayout?.frame.inset(by: UIEdgeInsets(top: -frameLayout.edgeInsets.top, left: -frameLayout.edgeInsets.left, bottom: -frameLayout.edgeInsets.bottom, right: -frameLayout.edgeInsets.right)) ?? .zero
		CATransaction.commit()
		
		guard let controlView = controlView else { return }
		
		let viewSize = controlView.bounds.size
		
		if !controlView.liveBadgeView.isHidden {
			let badgeSize = controlView.liveBadgeView.sizeThatFits(viewSize)
			controlView.liveBadgeView.frame = CGRect(x: (viewSize.width - badgeSize.width)/2, y: 10, width: badgeSize.width, height: badgeSize.height)
		}
		
		if !controlView.enlapseTimeLabel.isHidden {
			let labelSize = controlView.enlapseTimeLabel.sizeThatFits(viewSize)
			controlView.enlapseTimeLabel.frame = CGRect(x: 10, y: viewSize.height - labelSize.height - 10, width: labelSize.width, height: labelSize.height)
		}
	}
	
	open func cleanUI() {
		topGradientLayer.removeFromSuperlayer()
		bottomGradientLayer.removeFromSuperlayer()
	}
	
	open func allButtons() -> [UIButton] {
		return []
	}
	
	open func showLoader() {
		guard let controlView = controlView else { return }
		if controlView.loadingIndicatorView == nil {
			if #available(iOS 13.0, *) {
				controlView.loadingIndicatorView = UIActivityIndicatorView(style: .medium)
			}
			else {
				controlView.loadingIndicatorView = UIActivityIndicatorView(style: .white)
			}
			controlView.addSubview(controlView.loadingIndicatorView!)
		}
		
		controlView.loadingIndicatorView?.isHidden = false
		controlView.loadingIndicatorView?.startAnimating()
	}
	
	open func hideLoader() {
		controlView?.loadingIndicatorView?.isHidden = true
		controlView?.loadingIndicatorView?.stopAnimating()
	}
	
	open func update(withResource: UZPlayerResource?, video: UZVideoItem?, playlist: [UZVideoItem]?) {
		let isEmptyPlaylist = (playlist?.count ?? 0) < 2
		controlView?.nextButton.isHidden = isEmptyPlaylist
		controlView?.previousButton.isHidden = isEmptyPlaylist
//		controlView?.forwardButton.isHidden = !isEmptyPlaylist
//		controlView?.backwardButton.isHidden = !isEmptyPlaylist
	}
	
	open func alignLogo() {
		// align logo manually here if needed
	}
	
}