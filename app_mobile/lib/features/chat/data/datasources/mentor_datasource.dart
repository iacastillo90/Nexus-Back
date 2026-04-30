import '../../domain/entities/mentor_entity.dart';

/// Mentor data source with hardcoded AI mentors
class MentorDataSource {
  /// Get all AI mentors
  List<MentorEntity> getMentors() {
    return [
      const MentorEntity(
        id: 'echo',
        name: 'Echo',
        specialty: 'AI & Technology',
        avatar: '🤖',
        description: 'Your AI companion for tech insights and innovation',
        personality: 'Analytical, curious, and forward-thinking',
        expertise: [
          'Artificial Intelligence',
          'Machine Learning',
          'Tech Trends',
          'Innovation',
        ],
        isOnline: true,
      ),
      const MentorEntity(
        id: 'dr_luma',
        name: 'Dr. Luma',
        specialty: 'Science & Research',
        avatar: '🧬',
        description: 'Scientific guidance and research methodology expert',
        personality: 'Methodical, precise, and evidence-based',
        expertise: [
          'Scientific Method',
          'Research Design',
          'Data Analysis',
          'Biology & Chemistry',
        ],
        isOnline: true,
      ),
      const MentorEntity(
        id: 'cipher',
        name: 'Cipher',
        specialty: 'Security & Privacy',
        avatar: '🔐',
        description: 'Cybersecurity expert and privacy advocate',
        personality: 'Vigilant, strategic, and protective',
        expertise: [
          'Cybersecurity',
          'Encryption',
          'Privacy Protection',
          'Threat Analysis',
        ],
        isOnline: true,
      ),
      const MentorEntity(
        id: 'aurora',
        name: 'Aurora',
        specialty: 'Creativity & Design',
        avatar: '✨',
        description: 'Creative mentor for art, design, and innovation',
        personality: 'Imaginative, expressive, and inspiring',
        expertise: [
          'Creative Thinking',
          'Design Principles',
          'Art & Aesthetics',
          'Innovation',
        ],
        isOnline: true,
      ),
    ];
  }

  /// Get mentor by ID
  MentorEntity? getMentorById(String id) {
    try {
      return getMentors().firstWhere((mentor) => mentor.id == id);
    } catch (e) {
      return null;
    }
  }
}
