import Foundation

public enum UserDefaultsKeys: String, CaseIterable {
  case isMuted
  case isMutedSound
  case level
  case element1
  case element2
  case element3
  case element4
  case element5
  case element6
}

class UserDefaultsHelper {
  static let shared = UserDefaultsHelper()
  var level: Int {
    get {
      return UserDefaults.standard.integer(forKey: UserDefaultsKeys.level.rawValue)
    }
    set {
      guard newValue >= 0 else { return }
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.level.rawValue)
    }
  }
  
  var isMuted: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isMuted.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isMuted.rawValue)
    }
  }
  
  var isMutedSound: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isMutedSound.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isMutedSound.rawValue)
    }
  }
  
  var element1: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.element1.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.element1.rawValue)
    }
  }

  var element2: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.element2.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.element2.rawValue)
    }
  }
  
  var element3: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.element3.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.element3.rawValue)
    }
  }
  
  var element4: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.element4.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.element4.rawValue)
    }
  }
  
  var element5: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.element5.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.element5.rawValue)
    }
  }
  
  var element6: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.element6.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.element6.rawValue)
    }
  }
  
  init() {
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.isMuted.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.isMutedSound.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.level.rawValue : 0])
    
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.element1.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.element2.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.element3.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.element4.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.element5.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.element6.rawValue : false])

  }
}
