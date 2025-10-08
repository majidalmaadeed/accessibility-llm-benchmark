import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
} from 'react-native';

const MissingLanguageAttribute = () => {
  const [selectedLanguage, setSelectedLanguage] = useState('en');

  const articles = [
    {
      id: 1,
      title: 'Understanding Machine Learning',
      content: 'Machine learning is revolutionizing the way we approach data analysis and decision making. This comprehensive guide covers the fundamentals...',
      language: 'en',
      category: 'Technology',
      readTime: '5 min read',
      author: 'Dr. Sarah Johnson'
    },
    {
      id: 2,
      title: 'Bienvenue sur notre portail d\'actualités',
      content: 'Restez informé des dernières nouvelles et événements du monde entier.',
      language: 'fr',
      category: 'Général',
      readTime: '7 min read',
      author: 'Mike Chen'
    },
    {
      id: 3,
      title: 'Breaking News: Technology Update',
      content: 'New developments in artificial intelligence are changing the industry.',
      language: 'en',
      category: 'Technology',
      readTime: '4 min read',
      author: 'Emily Davis'
    },
    {
      id: 4,
      title: 'Actualités: Mise à jour technologique',
      content: 'Les nouveaux développements en intelligence artificielle transforment l\'industrie.',
      language: 'fr',
      category: 'Technologie',
      readTime: '6 min read',
      author: 'David Wilson'
    }
  ];

  return (
    <ScrollView style={styles.container}>
      {/* Header - Mixed languages without proper language attributes */}
      <View style={styles.header}>
        {}
        <Text style={styles.headerTitle}>News Portal / Portail d'actualités</Text>
        {}
        <Text style={styles.headerSubtitle}>Latest News / Dernières nouvelles</Text>
      </View>

      {}
      <View style={styles.languageContainer}>
        {}
        <Text style={styles.languageLabel}>Language / Langue:</Text>
        <View style={styles.languageButtons}>
          <TouchableOpacity
            style={[
              styles.languageButton,
              selectedLanguage === 'en' && styles.selectedLanguageButton
            ]}
            onPress={() => setSelectedLanguage('en')}
          >
            <Text style={[
              styles.languageButtonText,
              selectedLanguage === 'en' && styles.selectedLanguageButtonText
            ]}>
              English
            </Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={[
              styles.languageButton,
              selectedLanguage === 'fr' && styles.selectedLanguageButton
            ]}
            onPress={() => setSelectedLanguage('fr')}
          >
            <Text style={[
              styles.languageButtonText,
              selectedLanguage === 'fr' && styles.selectedLanguageButtonText
            ]}>
              Français
            </Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Articles List */}
      <View style={styles.articlesContainer}>
        {articles.map((article) => (
          <View key={article.id} style={styles.articleCard}>
            {/* Category and Language - Mixed content without language attributes */}
            <View style={styles.articleMeta}>
              {}
              <Text style={styles.articleCategory}>{article.category}</Text>
              {}
              <Text style={styles.articleLanguage}>
                {article.language === 'en' ? 'English' : 'Français'}
              </Text>
            </View>

            {}
            <Text style={styles.articleTitle}>{article.title}</Text>

            {}
            <Text style={styles.articleContent}>{article.content}</Text>

            {/* Author and Actions - Mixed language labels */}
            <View style={styles.articleFooter}>
              <Text style={styles.articleAuthor}>By {article.author}</Text>
              <View style={styles.articleActions}>
                {}
                <TouchableOpacity style={styles.readMoreButton}>
                  <Text style={styles.readMoreText}>
                    {article.language === 'en' ? 'Read More' : 'Lire la suite'}
                  </Text>
                </TouchableOpacity>
                {}
                <TouchableOpacity style={styles.shareButton}>
                  <Text style={styles.shareText}>
                    {article.language === 'en' ? 'Share' : 'Partager'}
                  </Text>
                </TouchableOpacity>
              </View>
            </View>
          </View>
        ))}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  header: {
    backgroundColor: '#1976D2',
    padding: 32,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 8,
    textAlign: 'center',
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#FFFFFF',
    opacity: 0.9,
    textAlign: 'center',
  },
  languageContainer: {
    flexDirection: 'row',
    backgroundColor: '#FFFFFF',
    padding: 16,
    margin: 16,
    borderRadius: 8,
    alignItems: 'center',
  },
  languageLabel: {
    fontSize: 16,
    fontWeight: '600',
    marginRight: 16,
  },
  languageButtons: {
    flexDirection: 'row',
  },
  languageButton: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 8,
    marginRight: 8,
    backgroundColor: '#FFFFFF',
    borderWidth: 1,
    borderColor: '#1976D2',
  },
  selectedLanguageButton: {
    backgroundColor: '#1976D2',
  },
  languageButtonText: {
    color: '#1976D2',
    fontWeight: '600',
  },
  selectedLanguageButtonText: {
    color: '#FFFFFF',
  },
  articlesContainer: {
    padding: 16,
  },
  articleCard: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    marginBottom: 16,
    borderRadius: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  articleMeta: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  articleCategory: {
    fontSize: 12,
    color: '#1976D2',
    backgroundColor: '#E3F2FD',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 4,
  },
  articleLanguage: {
    fontSize: 12,
    color: '#666666',
  },
  articleTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  articleContent: {
    fontSize: 14,
    color: '#666666',
    lineHeight: 20,
    marginBottom: 12,
  },
  articleFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  articleAuthor: {
    fontSize: 12,
    color: '#666666',
  },
  articleActions: {
    flexDirection: 'row',
  },
  readMoreButton: {
    backgroundColor: '#1976D2',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 4,
    marginRight: 8,
  },
  readMoreText: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: '600',
  },
  shareButton: {
    backgroundColor: '#FFFFFF',
    borderWidth: 1,
    borderColor: '#1976D2',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 4,
  },
  shareText: {
    color: '#1976D2',
    fontSize: 12,
    fontWeight: '600',
  },
});

export default MissingLanguageAttribute;
