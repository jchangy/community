package com.web.community.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.Collections;
import java.util.List;

/**
 * Represents the response from the news API containing a list of articles.
 */
public class NewsResponse {
    
    @JsonProperty("articles")
    private List<Article> articles;

    /**
     * Gets the list of articles.
     * @return a list of articles or an empty list if none are found.
     */
    public List<Article> getArticles() {
        return articles != null ? articles : Collections.emptyList();
    }

    /**
     * Sets the list of articles.
     * @param articles the list of articles to set.
     */
    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }
}
