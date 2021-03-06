// The MIT License (MIT)
// Copyright (c) 2016 Erik Little

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without
// limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
// Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

/// Represents a Discord Permission. Calculating Permissions involves bitwise operations.
public enum DiscordPermission : Int {
    /// User has all permissions.
    case all = -1
    /// The none permission. Mathmatical.
    case none = 0
    /// This user can create invites.
    case createInstantInvite = 0x00000001
    /// This user can kick members.
    case kickMembers = 0x00000002
    /// This user can ban members.
    case banMembers = 0x00000004
    /// This user is an admin.
    case administrator = 0x00000008
    /// This user can manage channels.
    case manageChannels = 0x00000010
    /// This user can manage the guild.
    case manageGuild = 0x00000020
    /// This user can add reactions.
    case addReactions = 0x00000040
    /// This user can read messages.
    case readMessages = 0x00000400
    /// This user can send messages.
    case sendMessages = 0x00000800
    /// This user can send tts messages.
    case sendTTSMessages = 0x00001000
    /// This user can manage messages.
    case manageMessages = 0x00002000
    /// This user can embed links.
    case embedLinks = 0x00004000
    /// This user can attach files.
    case attachFiles = 0x00008000
    /// This user read the message history.
    case readMessageHistory = 0x00010000
    /// This user can mention everyone.
    case mentionEveryone = 0x00020000
    /// This user can can add external emojis.
    case useExternalEmojis = 0x00040000
    /// This user can connect to a voice channel.
    case connect = 0x00100000
    /// This user can speak on a voice channel.
    case speak = 0x00200000
    /// This user can mute members.
    case muteMembers = 0x00400000
    /// This user can deafen members.
    case deafenMembers = 0x00800000
    /// This user can move members.
    case moveMembers = 0x01000000
    /// This user can use VAD.
    case useVAD = 0x02000000
    /// This user can change their nickname.
    case changeNickname = 0x04000000
    /// This user can manage nicknames.
    case manageNicknames = 0x08000000
    /// This user can manage roles.
    case manageRoles = 0x10000000
    /// This user can manage WebHooks
    case manageWebhooks = 0x20000000
    /// This user can manage emojis
    case manageEmojis = 0x40000000

    // MARK: Composite permissions

    /// All the channel permissions set to true.
    case allChannel = 0x33F7FC51

    /// All voice permissions set to true
    case voice = 0x3F00000

    /**
        Helper operator for permission math.

        - parameter lhs: a DiscordPermission
        - parameter rhs: a DiscordPermission

        - returns: the or of the two permissiosn
    */
    public static func |(lhs: DiscordPermission, rhs: DiscordPermission) -> Int {
        return lhs.rawValue | rhs.rawValue
    }

    /**
        Helper operator for permission math.

        - parameter lhs: a DiscordPermission
        - parameter rhs: a DiscordPermission

        - returns: the and of the two permissiosn
    */
    public static func &(lhs: DiscordPermission, rhs: DiscordPermission) -> Int {
        return lhs.rawValue & rhs.rawValue
    }

    /**
        Helper operator for permission math.

        - parameter lhs: an int
        - parameter rhs: a DiscordPermission

        - returns: the or of the two permissiosn
    */
    public static func |(lhs: Int, rhs: DiscordPermission) -> Int {
        return lhs | rhs.rawValue
    }

    /**
        Helper operator for permission math.

        - parameter lhs: an Int
        - parameter rhs: a DiscordPermission

        - returns: the and of the two permissiosn
    */
    public static func &(lhs: Int, rhs: DiscordPermission) -> Int {
        return lhs & rhs.rawValue
    }

    /**
        Helper operator for permission math.

        Ors the two permissions and assigns the result to `lhs`.

        - parameter lhs: a Int
        - parameter rhs: a DiscordPermission

        - returns: the or of the two permissiosn
    */
    public static func |=(lhs: inout Int, rhs: DiscordPermission) {
        lhs |= rhs.rawValue
    }

    /**
        Helper operator for permission math.

        Ands the two permissions and assigns the result to `lhs`.

        - parameter lhs: an Int
        - parameter rhs: a DiscordPermission
    */
    public static func &=(lhs: inout Int, rhs: DiscordPermission) {
        lhs &= rhs.rawValue
    }

    /**
        Determines if an Int and a permission represent the same thing.

        - parameter lhs: an Int
        - parameter rhs: a DiscordPermission
    */
    public static func ==(lhs: Int, rhs: DiscordPermission) -> Bool {
        return lhs == rhs.rawValue
    }

    /**
        Returns the inverse of this permission.

        - parameter rhs: The permission.
        - returns: The inverse of this permission
    */
    public static prefix func ~(rhs: DiscordPermission) -> Int {
        return ~rhs.rawValue
    }
}

/// Represents a permission overwrite type for a channel.
public enum DiscordPermissionOverwriteType : String, JSONRepresentable {
    /// A role overwrite.
    case role = "role"
    /// A member overwrite.
    case member = "member"

    func jsonValue() -> JSONRepresentable {
        return rawValue
    }
}

/// Represents a permission overwrite for a channel.
///
/// The `allow` and `deny` properties are bit fields.
public struct DiscordPermissionOverwrite : JSONAble {
    // MARK: Properties

    /// The snowflake id of this permission overwrite.
    public let id: String

    /// The type of this overwrite.
    public let type: DiscordPermissionOverwriteType

    /// The permissions that this overwrite is allowed to use.
    public var allow: Int

    /// The permissions that this overwrite is not allowed to use.
    public var deny: Int

    // MARK: Initializers

    /**
        Creates a new DiscordPermissionOverwrite

        - parameter id: The id of this overwrite
        - parameter type: The type of this overwrite
        - parameter allow: The permissions allowed
        - parameter deny: The permissions denied
    */
    public init(id: String, type: DiscordPermissionOverwriteType, allow: Int, deny: Int) {
        self.id = id
        self.type = type
        self.allow = allow
        self.deny = deny
    }

    init(permissionOverwriteObject: [String: Any]) {
        id = permissionOverwriteObject.get("id", or: "")
        type = DiscordPermissionOverwriteType(rawValue: permissionOverwriteObject.get("type", or: "")) ?? .role
        allow = permissionOverwriteObject.get("allow", or: 0)
        deny = permissionOverwriteObject.get("deny", or: 0)
    }

    static func overwritesFromArray(_ permissionOverwritesArray: [[String: Any]]) -> [String: DiscordPermissionOverwrite] {
        var overwrites = [String: DiscordPermissionOverwrite]()

        for overwriteObject in permissionOverwritesArray {
            let overwrite = DiscordPermissionOverwrite(permissionOverwriteObject: overwriteObject)

            overwrites[overwrite.id] = overwrite
        }

        return overwrites
    }
}
