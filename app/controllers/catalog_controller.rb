##
# Simplified catalog controller
class CatalogController < ApplicationController
  include Blacklight::Catalog

  configure_blacklight do |config|
    config.show.oembed_field = :oembed_url_ssm
    config.show.partials.insert(1, :oembed)
    #config.view.gallery.partials = [:index_header, :index]
    #config.view.masonry.partials = [:index]
    #config.view.slideshow.partials = [:index]

    #config.show.tile_source_field = :content_metadata_image_iiif_info_ssm
    #config.show.partials.insert(1, :openseadragon)

    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
        qt: 'search',
        rows: 10,
        fl: '*'
    }

    config.document_solr_path = 'get'
    config.document_unique_id_param = 'ids'

    # solr field configuration for search results/index views
    config.index.title_field = 'full_title_tesim'

    config.add_search_field 'all_fields', label: 'Everything'

    #config.add_index_field 'desc_metadata__language_tesim', :label => 'Language'

    config.add_sort_field 'relevance', sort: 'score desc', label: 'Relevance'
    config.add_sort_field 'title', sort: 'desc_metadata__title_ssi asc', label: 'Title'
    config.add_sort_field 'duration', sort: 'desc_metadata__duration_ssi asc', label: 'Duration'

    config.add_facet_field 'desc_metadata__date_ssi', :label => 'Year', :limit => true
    config.add_facet_field 'desc_metadata__Genre_sim', :label => 'Genre', :limit => true
    config.add_facet_field 'desc_metadata__publicationChannelName_sim', :label => 'Publisher', :limit => true
    config.add_facet_field 'desc_metadata__creator_sim', :label => 'Creator', :limit => true
    config.add_facet_field 'desc_metadata__singer_sim', :label => 'Soloist', :limit => true
    config.add_facet_field 'desc_metadata__Orchestration_sim', :label => 'Orchestra', :limit => true
    config.add_facet_field 'desc_metadata__Series_sim', :label => 'Series', :limit => true

    config.add_facet_fields_to_solr_request!

    config.add_field_configuration_to_solr_request!
  end
end
