// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatDataSourceHash() => r'56edd81e8ccc716298ebcbaec1dd03703cc2e268';

/// ☁️ **Proveedor de DataSource REST (Chat)**
///
/// Copied from [chatDataSource].
@ProviderFor(chatDataSource)
final chatDataSourceProvider = AutoDisposeProvider<ChatDataSource>.internal(
  chatDataSource,
  name: r'chatDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatDataSourceRef = AutoDisposeProviderRef<ChatDataSource>;
String _$mentorDataSourceHash() => r'c153931a81cf4f4cd80d389ccffffa636973ebb0';

/// 🧠 **Proveedor de DataSource de Mentores**
///
/// Copied from [mentorDataSource].
@ProviderFor(mentorDataSource)
final mentorDataSourceProvider = AutoDisposeProvider<MentorDataSource>.internal(
  mentorDataSource,
  name: r'mentorDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mentorDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MentorDataSourceRef = AutoDisposeProviderRef<MentorDataSource>;
String _$chatWebSocketDataSourceHash() =>
    r'121e44069cc45e89f0ddbb38b4b164b5e6ced229';

/// 🔌 **Proveedor de WebSocket (Singleton)**
///
/// Mantiene la conexión persistente del chat.
/// Se conecta automáticamente cuando el usuario se autentica.
///
/// Copied from [chatWebSocketDataSource].
@ProviderFor(chatWebSocketDataSource)
final chatWebSocketDataSourceProvider =
    Provider<ChatWebSocketDataSource>.internal(
  chatWebSocketDataSource,
  name: r'chatWebSocketDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatWebSocketDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatWebSocketDataSourceRef = ProviderRef<ChatWebSocketDataSource>;
String _$chatRepositoryHash() => r'1d44e0edf705c05682b57b5f61e5cf2b1f5a8535';

/// 🛡️ **Proveedor de Repositorio (Chat)**
///
/// Combina REST y WebSockets.
///
/// Copied from [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = AutoDisposeProvider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatRepositoryRef = AutoDisposeProviderRef<ChatRepository>;
String _$mentorsHash() => r'b187babc844392136f9f7efb8a15bf454b027e34';

/// 👥 **Lista de Mentores**
///
/// Provee la lista estática de mentores AI disponibles.
///
/// Copied from [Mentors].
@ProviderFor(Mentors)
final mentorsProvider =
    AutoDisposeNotifierProvider<Mentors, List<MentorEntity>>.internal(
  Mentors.new,
  name: r'mentorsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mentorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Mentors = AutoDisposeNotifier<List<MentorEntity>>;
String _$chatMessagesHash() => r'ede3accbe4743d45847eea4bf3b6f386dc49d6a3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ChatMessages
    extends BuildlessAutoDisposeAsyncNotifier<List<MessageEntity>> {
  late final String mentorId;

  FutureOr<List<MessageEntity>> build(
    String mentorId,
  );
}

/// 💬 **Controlador de Mensajes de Chat**
///
/// Gestiona la lista de mensajes de una conversación específica.
/// Escucha eventos de WebSocket para actualizaciones en tiempo real.
///
/// **Argumentos:**
/// - [mentorId]: ID de la conversación/mentor.
///
/// Copied from [ChatMessages].
@ProviderFor(ChatMessages)
const chatMessagesProvider = ChatMessagesFamily();

/// 💬 **Controlador de Mensajes de Chat**
///
/// Gestiona la lista de mensajes de una conversación específica.
/// Escucha eventos de WebSocket para actualizaciones en tiempo real.
///
/// **Argumentos:**
/// - [mentorId]: ID de la conversación/mentor.
///
/// Copied from [ChatMessages].
class ChatMessagesFamily extends Family<AsyncValue<List<MessageEntity>>> {
  /// 💬 **Controlador de Mensajes de Chat**
  ///
  /// Gestiona la lista de mensajes de una conversación específica.
  /// Escucha eventos de WebSocket para actualizaciones en tiempo real.
  ///
  /// **Argumentos:**
  /// - [mentorId]: ID de la conversación/mentor.
  ///
  /// Copied from [ChatMessages].
  const ChatMessagesFamily();

  /// 💬 **Controlador de Mensajes de Chat**
  ///
  /// Gestiona la lista de mensajes de una conversación específica.
  /// Escucha eventos de WebSocket para actualizaciones en tiempo real.
  ///
  /// **Argumentos:**
  /// - [mentorId]: ID de la conversación/mentor.
  ///
  /// Copied from [ChatMessages].
  ChatMessagesProvider call(
    String mentorId,
  ) {
    return ChatMessagesProvider(
      mentorId,
    );
  }

  @override
  ChatMessagesProvider getProviderOverride(
    covariant ChatMessagesProvider provider,
  ) {
    return call(
      provider.mentorId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatMessagesProvider';
}

/// 💬 **Controlador de Mensajes de Chat**
///
/// Gestiona la lista de mensajes de una conversación específica.
/// Escucha eventos de WebSocket para actualizaciones en tiempo real.
///
/// **Argumentos:**
/// - [mentorId]: ID de la conversación/mentor.
///
/// Copied from [ChatMessages].
class ChatMessagesProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChatMessages, List<MessageEntity>> {
  /// 💬 **Controlador de Mensajes de Chat**
  ///
  /// Gestiona la lista de mensajes de una conversación específica.
  /// Escucha eventos de WebSocket para actualizaciones en tiempo real.
  ///
  /// **Argumentos:**
  /// - [mentorId]: ID de la conversación/mentor.
  ///
  /// Copied from [ChatMessages].
  ChatMessagesProvider(
    String mentorId,
  ) : this._internal(
          () => ChatMessages()..mentorId = mentorId,
          from: chatMessagesProvider,
          name: r'chatMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatMessagesHash,
          dependencies: ChatMessagesFamily._dependencies,
          allTransitiveDependencies:
              ChatMessagesFamily._allTransitiveDependencies,
          mentorId: mentorId,
        );

  ChatMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mentorId,
  }) : super.internal();

  final String mentorId;

  @override
  FutureOr<List<MessageEntity>> runNotifierBuild(
    covariant ChatMessages notifier,
  ) {
    return notifier.build(
      mentorId,
    );
  }

  @override
  Override overrideWith(ChatMessages Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatMessagesProvider._internal(
        () => create()..mentorId = mentorId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mentorId: mentorId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatMessages, List<MessageEntity>>
      createElement() {
    return _ChatMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesProvider && other.mentorId == mentorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mentorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatMessagesRef
    on AutoDisposeAsyncNotifierProviderRef<List<MessageEntity>> {
  /// The parameter `mentorId` of this provider.
  String get mentorId;
}

class _ChatMessagesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatMessages,
        List<MessageEntity>> with ChatMessagesRef {
  _ChatMessagesProviderElement(super.provider);

  @override
  String get mentorId => (origin as ChatMessagesProvider).mentorId;
}

String _$typingIndicatorHash() => r'5407176e00600ff06f790f52f0844de65a24bf60';

/// ⌨️ **Indicador de Typing Global**
///
/// Mantiene un mapa de usuarios que están escribiendo.
///
/// Copied from [TypingIndicator].
@ProviderFor(TypingIndicator)
final typingIndicatorProvider =
    AutoDisposeNotifierProvider<TypingIndicator, Map<String, bool>>.internal(
  TypingIndicator.new,
  name: r'typingIndicatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$typingIndicatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TypingIndicator = AutoDisposeNotifier<Map<String, bool>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
