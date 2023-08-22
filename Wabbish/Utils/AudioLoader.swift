//
//  SoundLoader.swift
//  ARtestt
//
//  Created by David Mahbubi on 16/08/23.
//

import AVFAudio

enum AudioEffectType: String, CaseIterable {
    case throw_trash = "dish_placed"
    case pick_trash = "pick_trash"
    case game_over = "party_sad_horn"
    case game_finished = "sucessfull_horn"
    case alert = "quick_chime"
}

class AudioLoader {
    
    static var audios: [AudioEffectType: AVAudioPlayer?] = [:]
    static var audioFiles: [String] = ["dish_placed", "applause", "electric_switch", "party_sad_horn", "successfull_horn"]
    
    static func loadAudio() -> Void {
        for audioFile in AudioEffectType.allCases {
            guard let audioFileURL = Bundle.main.url(forResource: audioFile.rawValue, withExtension: "wav") else { continue }
            audios[audioFile] = try? AVAudioPlayer(contentsOf: audioFileURL)
        }
    }
    
    static func playAudio(on audioType: AudioEffectType) -> Void {
        audios[audioType]??.play()
    }
}
