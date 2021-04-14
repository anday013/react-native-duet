//
//  RNDuetModule.swift
//  ttoko
//
//  Created by Anday on 12.02.21.
//

import Foundation
import AVFoundation

@objc(RNDuetModule)
class RNDuetModule: NSObject, RCTBridgeModule{
  static func moduleName() -> String! {
    return "RNDuetModule";
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true;
  }
  
  
  @objc
  func duetFunction( _ firstVideoUrlString: String, secondVideoUrlString: String, orientation: String, reverse: Bool , isMuted: Bool,success: @escaping RCTResponseSenderBlock)
  {
    let isVertical: Bool = (orientation == "V" ? true : false);
    let heightMultiplier: CGFloat = (isVertical ? 0.5 : 1);
    let firstVideoUrl = URL(string: firstVideoUrlString)!
    let secondVideoUrl = URL(string: secondVideoUrlString)!
    let audioUrl = URL(string: firstVideoUrlString)!
    let audioUrl2 = URL(string: secondVideoUrlString)!
    
    let savePathUrl : NSURL = NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/duetVideo.mp4")
    do { // delete old video
      try FileManager.default.removeItem(at: savePathUrl as URL)
    } catch { print(error.localizedDescription) }
    
    let mutableVideoComposition : AVMutableVideoComposition = AVMutableVideoComposition()
    let mixComposition : AVMutableComposition = AVMutableComposition()
    
    let afirstVideoAsset : AVAsset = AVAsset(url: firstVideoUrl)
    let asecondVideoAsset : AVAsset = AVAsset(url: secondVideoUrl)
    let aaudioAsset: AVAsset = AVAsset(url: audioUrl)
    let aaudioAsset2: AVAsset = AVAsset(url: audioUrl2)
    
    let afirstVideoTrack : AVAssetTrack = afirstVideoAsset.tracks(withMediaType: AVMediaType.video)[0]
    let asecondVideoTrack : AVAssetTrack = asecondVideoAsset.tracks(withMediaType: AVMediaType.video)[0]
    
    
    
    let maxHeight = max(afirstVideoTrack.naturalSize.height, asecondVideoTrack.naturalSize.height)
    let maxWidth = (isVertical ? max(afirstVideoTrack.naturalSize.width, asecondVideoTrack.naturalSize.width) : 720)
    
    let heightProportion = maxHeight / min(afirstVideoTrack.naturalSize.height, asecondVideoTrack.naturalSize.height)
    let widthProportion = maxWidth / min(afirstVideoTrack.naturalSize.width, asecondVideoTrack.naturalSize.width)
    
    let mutableCompositionfirstVideoTrack : AVMutableCompositionTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)!
    do{
      try mutableCompositionfirstVideoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: afirstVideoAsset.duration), of: afirstVideoTrack, at: CMTime.zero)
    }catch {  print("Mutable Error") }
    
    let mutableCompositionsecondVideoTrack : AVMutableCompositionTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)!
    do{
      try mutableCompositionsecondVideoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: afirstVideoAsset.duration), of: asecondVideoTrack , at: CMTime.zero)
    }catch{ print("Mutable Error") }
    
    
    
    
    // 1 audio
    if !isMuted && !aaudioAsset.tracks(withMediaType: AVMediaType.audio).isEmpty {
      let mutableCompositionAudioTrack : AVMutableCompositionTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
      do{
        try mutableCompositionAudioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aaudioAsset.duration), of: aaudioAsset.tracks(withMediaType: AVMediaType.audio)[0] , at: CMTime.zero)
      }catch{ print("Mutable Error") }
    }
    
    // 2 audio
    if !isMuted && !aaudioAsset2.tracks(withMediaType: AVMediaType.audio).isEmpty{
      let mutableCompositionAudioTrack2 : AVMutableCompositionTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
      do{
        try mutableCompositionAudioTrack2.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aaudioAsset.duration), of: aaudioAsset2.tracks(withMediaType: AVMediaType.audio)[0] , at: CMTime.zero)
      }catch{ print("Mutable Error") }
    }
    
    
    let staticMove : CGAffineTransform = CGAffineTransform.init(translationX: 0, y: 0)
    let dynamicMove : CGAffineTransform = CGAffineTransform.init(translationX: (isVertical ? 0 : 360), y: (isVertical ? maxHeight / 2 : 0))
    // First video instructions
    let firstVideoHorizontalScale = (maxWidth / 2) / afirstVideoTrack.naturalSize.width
    let mainInstruction = AVMutableVideoCompositionInstruction()
    mainInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration:  CMTimeMaximum(afirstVideoAsset.duration, asecondVideoAsset.duration))
    
    let firstVideoLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: mutableCompositionfirstVideoTrack)
    let newScale : CGAffineTransform = CGAffineTransform.init(scaleX: (isVertical ? firstVideoHorizontalScale * 2 : firstVideoHorizontalScale), y: (afirstVideoTrack.naturalSize.height > asecondVideoTrack.naturalSize.height ? 1 : heightProportion) * heightMultiplier)
    
    let calc:CGFloat = (-afirstVideoTrack.naturalSize.width + (afirstVideoTrack.naturalSize.height - afirstVideoTrack.naturalSize.width) - afirstVideoTrack.naturalSize.width / 12)
    
    var transform:CGAffineTransform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    transform = transform.translatedBy(x: isVertical ? calc - afirstVideoTrack.naturalSize.width / 2.28 : calc, y: 0.0)
    
    
    firstVideoLayerInstruction.setTransform(newScale.concatenating(reverse ? dynamicMove : staticMove), at: CMTime.zero)
    
    
    // Second Video Instructions
    let secondVideoHorizontalScale = (maxWidth / 2) / asecondVideoTrack.naturalSize.width
    let secondVideoLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: mutableCompositionsecondVideoTrack)
    let savedScale : CGAffineTransform = CGAffineTransform.init(scaleX: (isVertical ? secondVideoHorizontalScale * 2 : secondVideoHorizontalScale) , y: (afirstVideoTrack.naturalSize.height < asecondVideoTrack.naturalSize.height ? 1 : heightProportion) * heightMultiplier)
    
    secondVideoLayerInstruction.setTransform(savedScale.concatenating(reverse ? staticMove : dynamicMove), at: CMTime.zero)
    
    
    mainInstruction.layerInstructions = [firstVideoLayerInstruction, secondVideoLayerInstruction]
    
    
    mutableVideoComposition.instructions = [mainInstruction]
    mutableVideoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
    mutableVideoComposition.renderSize = CGSize(width: maxWidth , height: maxHeight)
    
    let finalPath = savePathUrl.absoluteString!
    let assetExport: AVAssetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPreset640x480)!
    assetExport.videoComposition = mutableVideoComposition
    assetExport.outputFileType = AVFileType.mp4
    
    assetExport.outputURL = savePathUrl as URL
    assetExport.shouldOptimizeForNetworkUse = true
    
    assetExport.exportAsynchronously { () -> Void in
      switch assetExport.status {
      
      case AVAssetExportSession.Status.completed:
        success([finalPath])
      case  AVAssetExportSession.Status.failed:
        print("failed \(String(describing: assetExport.error))")
      case AVAssetExportSession.Status.cancelled:
        print("cancelled \(String(describing: assetExport.error))")
      default:
        print("complete")
      }
    }
    
  }
}
