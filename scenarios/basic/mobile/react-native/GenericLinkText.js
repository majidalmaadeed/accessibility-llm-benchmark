import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  Linking,
} from 'react-native';

const GenericLinkText = () => {
  const [selectedArticle, setSelectedArticle] = useState(null);

  const articles = [
    {
      id: 1,
      title: 'Understanding React Native Performance Optimization',
      excerpt: 'Learn how to optimize your React Native applications for better performance and user experience.',
      category: 'Development',
      readTime: '5 min read',
      author: 'John Smith',
      date: '2024-01-15',
      url: 'https://example.com/react-native-performance'
    },
    {
      id: 2,
      title: 'Mobile UI/UX Design Best Practices',
      excerpt: 'Essential design principles for creating intuitive and accessible mobile interfaces.',
      category: 'Design',
      readTime: '7 min read',
      author: 'Sarah Johnson',
      date: '2024-01-12',
      url: 'https://example.com/mobile-ui-design'
    },
    {
      id: 3,
      title: 'Cross-Platform Development Strategies',
      excerpt: 'Compare different approaches to building apps that work across multiple platforms.',
      category: 'Development',
      readTime: '10 min read',
      author: 'Mike Chen',
      date: '2024-01-10',
      url: 'https://example.com/cross-platform-strategies'
    },
    {
      id: 4,
      title: 'State Management in Modern React',
      excerpt: 'Explore different state management solutions for complex React applications.',
      category: 'Development',
      readTime: '8 min read',
      author: 'Emily Davis',
      date: '2024-01-08',
      url: 'https://example.com/react-state-management'
    }
  ];

  const handleReadMore = (url) => {
    Linking.openURL(url);
  };

  const handleArticlePress = (article) => {
    setSelectedArticle(article);
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Tech Blog</Text>
        <Text style={styles.headerSubtitle}>Latest articles and insights</Text>
      </View>

      {/* Featured Article */}
      <View style={styles.featuredContainer}>
        <Text style={styles.sectionTitle}>Featured Article</Text>
        <View style={styles.featuredCard}>
          <Image
            source={{ uri: 'https://via.placeholder.com/400x200' }}
            style={styles.featuredImage}
            accessibilityLabel="Featured article image"
          />
          <View style={styles.featuredContent}>
            <Text style={styles.featuredCategory}>Development</Text>
            <Text style={styles.featuredTitle}>
              Building Scalable React Native Applications
            </Text>
            <Text style={styles.featuredExcerpt}>
              Discover the key principles and patterns for creating maintainable and scalable React Native applications that can grow with your business needs.
            </Text>
            <View style={styles.featuredMeta}>
              <Text style={styles.featuredAuthor}>Alex Thompson</Text>
              <Text style={styles.featuredDate}>January 20, 2024</Text>
              <Text style={styles.featuredReadTime}>12 min read</Text>
            </View>
            <TouchableOpacity 
              style={styles.featuredButton}
              onPress={() => handleReadMore('https://example.com/scalable-react-native')}
            >
              <Text style={styles.featuredButtonText}>Read more</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>

      {/* Articles List */}
      <View style={styles.articlesContainer}>
        <Text style={styles.sectionTitle}>Recent Articles</Text>
        {articles.map((article) => (
          <View key={article.id} style={styles.articleCard}>
            <View style={styles.articleImageContainer}>
              <Image
                source={{ uri: 'https://via.placeholder.com/120x80' }}
                style={styles.articleImage}
                accessibilityLabel={`Article image for ${article.title}`}
              />
            </View>
            
            <View style={styles.articleContent}>
              <View style={styles.articleHeader}>
                <Text style={styles.articleCategory}>{article.category}</Text>
                <Text style={styles.articleReadTime}>{article.readTime}</Text>
              </View>
              
              <Text style={styles.articleTitle}>{article.title}</Text>
              <Text style={styles.articleExcerpt}>{article.excerpt}</Text>
              
              <View style={styles.articleMeta}>
                <Text style={styles.articleAuthor}>By {article.author}</Text>
                <Text style={styles.articleDate}>{formatDate(article.date)}</Text>
              </View>
              
              <View style={styles.articleActions}>
                <TouchableOpacity 
                  style={styles.readMoreButton}
                  onPress={() => handleReadMore(article.url)}
                >
                  <Text style={styles.readMoreText}>Read more</Text>
                </TouchableOpacity>
                
                <TouchableOpacity 
                  style={styles.shareButton}
                  onPress={() => handleArticlePress(article)}
                >
                  <Text style={styles.shareText}>Share</Text>
                </TouchableOpacity>
              </View>
            </View>
          </View>
        ))}
      </View>

      {/* Newsletter Signup */}
      <View style={styles.newsletterContainer}>
        <Text style={styles.newsletterTitle}>Stay Updated</Text>
        <Text style={styles.newsletterDescription}>
          Get the latest articles delivered to your inbox
        </Text>
        <TouchableOpacity style={styles.newsletterButton}>
          <Text style={styles.newsletterButtonText}>Subscribe</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.newsletterLink}>
          <Text style={styles.newsletterLinkText}>Read more</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
  },
  header: {
    backgroundColor: '#2C3E50',
    padding: 24,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#BDC3C7',
  },
  featuredContainer: {
    padding: 16,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 16,
  },
  featuredCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    overflow: 'hidden',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
  },
  featuredImage: {
    width: '100%',
    height: 200,
  },
  featuredContent: {
    padding: 20,
  },
  featuredCategory: {
    fontSize: 14,
    color: '#3498DB',
    fontWeight: '600',
    marginBottom: 8,
  },
  featuredTitle: {
    fontSize: 22,
    fontWeight: 'bold',
    color: '#2C3E50',
    marginBottom: 12,
    lineHeight: 28,
  },
  featuredExcerpt: {
    fontSize: 16,
    color: '#7F8C8D',
    lineHeight: 24,
    marginBottom: 16,
  },
  featuredMeta: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 20,
  },
  featuredAuthor: {
    fontSize: 14,
    color: '#7F8C8D',
  },
  featuredDate: {
    fontSize: 14,
    color: '#7F8C8D',
  },
  featuredReadTime: {
    fontSize: 14,
    color: '#7F8C8D',
  },
  featuredButton: {
    backgroundColor: '#3498DB',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
    alignSelf: 'flex-start',
  },
  featuredButtonText: {
    color: '#FFFFFF',
    fontWeight: '600',
    fontSize: 16,
  },
  articlesContainer: {
    padding: 16,
  },
  articleCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    flexDirection: 'row',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  articleImageContainer: {
    width: 120,
    height: 80,
    marginRight: 16,
  },
  articleImage: {
    width: 120,
    height: 80,
    borderRadius: 8,
  },
  articleContent: {
    flex: 1,
  },
  articleHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  articleCategory: {
    fontSize: 12,
    color: '#3498DB',
    fontWeight: '600',
  },
  articleReadTime: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  articleTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 8,
    lineHeight: 22,
  },
  articleExcerpt: {
    fontSize: 14,
    color: '#7F8C8D',
    lineHeight: 20,
    marginBottom: 12,
  },
  articleMeta: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 12,
  },
  articleAuthor: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  articleDate: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  articleActions: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  readMoreButton: {
    backgroundColor: '#3498DB',
    paddingVertical: 8,
    paddingHorizontal: 16,
    borderRadius: 6,
  },
  readMoreText: {
    color: '#FFFFFF',
    fontWeight: '600',
    fontSize: 14,
  },
  shareButton: {
    backgroundColor: '#FFFFFF',
    borderWidth: 1,
    borderColor: '#3498DB',
    paddingVertical: 8,
    paddingHorizontal: 16,
    borderRadius: 6,
  },
  shareText: {
    color: '#3498DB',
    fontWeight: '600',
    fontSize: 14,
  },
  newsletterContainer: {
    backgroundColor: '#34495E',
    margin: 16,
    padding: 24,
    borderRadius: 12,
    alignItems: 'center',
  },
  newsletterTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 8,
  },
  newsletterDescription: {
    fontSize: 16,
    color: '#BDC3C7',
    textAlign: 'center',
    marginBottom: 20,
  },
  newsletterButton: {
    backgroundColor: '#E74C3C',
    paddingVertical: 12,
    paddingHorizontal: 32,
    borderRadius: 8,
    marginBottom: 12,
  },
  newsletterButtonText: {
    color: '#FFFFFF',
    fontWeight: '600',
    fontSize: 16,
  },
  newsletterLink: {
    paddingVertical: 8,
  },
  newsletterLinkText: {
    color: '#3498DB',
    fontSize: 14,
  },
});

export default GenericLinkText;
