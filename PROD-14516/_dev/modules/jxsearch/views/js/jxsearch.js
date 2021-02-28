/*
 * 2017 Zemez
 *
 * JX Search
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the General Public License (GPL 2.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/GPL-2.0
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade the module to newer
 * versions in the future.
 *
 * @author     Zemez (Alexander Grosul)
 * @copyright  2017 Zemez
 * @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */

if (typeof Object.create !== 'function') {
	Object.create = function (obj) {
		function F() {
		}

		F.prototype = obj;
		return new F();
	};
}

(function ($, window, document, undefined) {
	var jxSearchQueries = [];
	var jxPrestashopSearch = {
		init: function (options, elem) {
			var self = this;
			self.elem = elem;
			self.$elem = $(elem);
			self.$elem.attr('autocomplete', 'off');
			self.options = $.extend({}, $.fn.jxPsSearch.options, options);

			if (self.options.jxajaxsearch) {
				self.$elem.bind('keyup', function(e) {
					if (self.options.jxajaxsearch) {
						self.ajaxSearch(self.$elem);
					}
				});
				$('' + self.options.categorySelector + '').bind('change', function(e) {
					if (self.options.jxajaxsearch) {
						self.ajaxSearch(self.$elem);
					}
				});
			}
      self.jxsearchToggle();

			$(document).on('click', '.jxsearch-row', function() {
				location.href = $(this).find('.jxsearch-inner-row').attr('data-href');
			});

			if (self.options.showAllResults) {
				$(document).on('click', ''+self.options.resultContainer+' .jxsearch-alllink', function(e) {
					e.preventDefault();
					self.showAllResult($(this));
				});
			}

			if (self.options.navigationMode) {
				$(document).on('click', ''+self.options.resultContainer+' .navigation .prev', function(e) {
					e.preventDefault();
					if (!$(this).hasClass('disabled')) {
						self.showPrevPage($(this));
					}
				});

				$(document).on('click', ''+self.options.resultContainer+' .navigation .next', function(e) {
					e.preventDefault();
					if (!$(this).hasClass('disabled')) {
						self.showNextPage($(this));
					}
				});
			}

			if (self.options.pagerMode) {
				$(document).on('click', ''+self.options.resultContainer+' .pager-button', function(e) {
					e.preventDefault();
					if (!$(this).hasClass('active')) {
						self.goToPage($(this));
					}
				});
			}

			$(document).on('click', ''+self.options.resultContainer+', #'+self.$elem.context.id+', '+self.options.categorySelector+'', function(e) {
				e.stopPropagation();
			});

			$(document).on('click', function(e) {
				e.stopPropagation();
        self.closeJxSearchResult();
			});
		},
		ajaxSearch: function(elem) {
			var self   = this;
			if (elem.val().length >= self.options.minQeuryLength) {
				self.stopJxSearchQueries();
				self.addSearchLoader();
				var category = $(''+self.options.categorySelector+'').val();
				let jxSearchQuery = $.ajax({
					url      : self.options.jxajaxsearchurl,
					headers  : {"cache-control" : "no-cache"},
					dataType : 'json',
					data     : {
						ajaxSearch : 1,
						category   : category,
						q          : elem.val()
					},
					success  : function(response) {
						if (response.result) {
							self.searchDropdown(self.buildSearchResponse(response.result, response.total), elem);
							if (self.options.resultHighlight) {
								self.highlightQuery();
							}
						} else {
							self.searchDropdown(self.buildEmptyResponse(response.empty), elem);
						}
					}
				});
				jxSearchQueries.push(jxSearchQuery);
			} else {
				self.stopJxSearchQueries();
				self.closeJxSearchResult();
			}
		},
		stopJxSearchQueries: function() {
			for(var i = 0; i < jxSearchQueries.length; i++) {
				jxSearchQueries[i].abort();
			}
			jxSearchQueries = [];
		},
		closeJxSearchResult: function() {
      let searchResult = $(''+this.options.resultContainer+'');
      searchResult.slideUp();
      setTimeout(function(){
        searchResult.remove();
      },800);
    },
		addSearchLoader: function() {
			var search_result = $(''+this.options.resultContainer+'');
			if (typeof(search_result) != 'undefined' && search_result.length) {
				search_result.addClass('loading');
			}
		},
		removeSearchLoader: function() {
			var search_result = $(''+this.options.resultContainer+'');
			if (typeof(search_result) != 'undefined' && search_result.length && search_result.hasClass('loading')) {
				search_result.removeAttr('class');
			}
		},
		searchDropdown: function(data, elem) {
			var search_result = $(''+this.options.resultContainer+'');
			if (typeof(search_result) != 'undefined' && search_result.length) {
				search_result.html(data);
			} else {
        elem.closest('#jxsearchblock').find('.jxsearch-result').append('<div id="'+this.options.resultContainerId+'" style="display: none;">'+data+'</div>');
        $('#' + this.options.resultContainerId).slideDown();
      }
			this.removeSearchLoader();
		},
		buildEmptyResponse: function(data) {
			return "<div class='px-3 py-2'>" + data + "</div>";
		},
		buildSearchResponse: function(data, total) {
			var response_content = '';
			if (data.length > 0) {
				if (this.options.pagerMode && this.options.itemsToShow > 0 && !this.options.navigationMode) {
					response_content += this.buildSearchResponsePages(data, total);
					response_content += this.buildSearchResponsePagesPagers(data, total);
				} else if (this.options.navigationMode && this.options.navigationPosition) {
					if (this.options.navigationPosition == 'both' || this.options.navigationPosition == 'top') {
						response_content += this.buildSearchResponseNav(data, total, 'top');
					}

					response_content += this.buildSearchResponsePages(data, total);

					if (this.options.navigationPosition == 'both' || this.options.navigationPosition == 'bottom') {
						response_content += this.buildSearchResponseNav(data, total, 'bottom');
					}
				} else {
					var hiddenItem = '';

					for (var i = 0; i < total; i++) {
						if (this.options.showAllResults && (i + 1 > this.options.itemsToShow)) {
							var hiddenItem = ' hidden-row';
						}
						response_content += '<div class="jxsearch-row '+hiddenItem+'">'+data[i]+'</div>';
						if (!this.options.showAllResults && (i + 1 == this.options.itemsToShow)) {
							break;
						}
					}
				}

				if (this.options.showAllResults && (total > this.options.itemsToShow)) {
					response_content += this.addShowAll(total, total - this.options.itemsToShow);
				}
			}

			return response_content;
		},
		buildSearchResponsePages: function(data, total) {
			var response_content = '';
			var pages = Math.ceil(total/this.options.itemsToShow);
			var hiddenClass = '';

			for (var p = 1; p < pages + 1; p++) {
				var from = (p - 1) * this.options.itemsToShow;
				var to = parseInt(from) + parseInt(this.options.itemsToShow);
				response_content += '<div class="search-page'+hiddenClass+' res-'+from+'-'+to+'" data-page-num="'+p+'">';

				for (var i = 0; i < total; i++) {
					if (i >= from && i < to) {
						response_content += '<div class="jxsearch-row">'+data[i]+'</div>';
					}
				}

				response_content += '</div>';
				hiddenClass = ' hidden-page';
			}

			return response_content;
		},
		buildSearchResponsePagesPagers: function (data, total) {
			var pages = Math.ceil(total/this.options.itemsToShow);
			var pagers = '';
			var active = ' active';
			if (pages > 1) {
				pagers += '<div class="pagers">';
				for (var i = 1; i < pages + 1; i++) {
					pagers += '<a href="#" class="pager-button '+active+'" data-page-num ="' + i + '">' + i + '</a>';
					active = '';
				}
				pagers += '</div>';
			}
			return pagers;
		},
		buildSearchResponsePagesCounter: function(total) {
			var count = '';
			count += '<div class="count-pages"><span class="current">1</span>/<span class="total">'+total+'</span></div>';
			return count;
		},
		setSearchResponsePagesCurrent: function(page) {
			$(''+this.options.resultContainer+' .count-pages .current').html(page);
		},
		buildSearchResponseNav: function(data, total, position) {
			var pages = Math.ceil(total/this.options.itemsToShow);
			var nav = '';
			if (pages > 1) {
				nav += '<div class="navigation ' + position + '">';
				nav += '<a href="#" class="icon-caret-left prev disabled"></a>';
				if (this.options.pagerMode && this.options.itemsToShow > 0) {
					nav += this.buildSearchResponsePagesPagers(data, total);
				} else {
					nav += this.buildSearchResponsePagesCounter(pages);
				}
				nav += '<a href="#" class="icon-caret-right next"></a>';
				nav += '</div>';
			}
			return nav;
		},
		showPrevPage: function(elem) {
			var prevPage = parseInt($(''+this.options.resultContainer+'').find('.search-page:visible').attr('data-page-num')) -1;

			this.showPage(prevPage);

			this.setSearchResponsePagesCurrent(prevPage);
			if (this.options.pagerMode) {
				this.addActivePager(prevPage);
			}

			this.setSearchResponsePagesCurrent(prevPage);
			this.disableNavButton('next', 'prev', prevPage);
		},
		showNextPage: function(elem) {
			var nextPage = parseInt($(''+this.options.resultContainer+'').find('.search-page:visible').attr('data-page-num')) + 1;

			this.showPage(nextPage);
			this.setSearchResponsePagesCurrent(nextPage);
			if (this.options.pagerMode) {
				this.addActivePager(nextPage);
			}
			this.disableNavButton('prev', 'next', nextPage);
		},
		showPage: function(page) {
			$(''+this.options.resultContainer+'').find('.search-page').each(function() {
				if ($(this).attr('data-page-num') != page) {
					$(this).addClass('hidden-page');
				} else {
					$(this).removeClass('hidden-page');
				}
			});
		},
		disableNavButton: function(name, name1, page) {
			var $elem = $(''+this.options.resultContainer+'');
			var pages = 1;
			if (name1 == 'next') {
				var pages = $elem.find('.search-page').length;
			}

			$(''+this.options.resultContainer+' a.'+name+'').removeClass('disabled');

			if (page == pages) {
				$(''+this.options.resultContainer+' a.'+name1+'').addClass('disabled');
			} else {
				$(''+this.options.resultContainer+' a.'+name1+'').removeClass('disabled');
			}
		},
		goToPage: function(elem) {
			var $elem = $(''+this.options.resultContainer+'');
			var pageToGo = elem.attr('data-page-num');

			this.addActivePager(pageToGo);
			if (pageToGo == 1) {
				this.disableNavButton('next', 'prev', pageToGo);
			} else {
				this.disableNavButton('prev', 'next', pageToGo);
			}

			this.showPage(pageToGo);
		},
		addActivePager: function(page) {
			$(''+this.options.resultContainer+'').find('.pagers a').each(function() {
				if ($(this).attr('data-page-num') != page) {
					$(this).removeClass('active');
				} else {
					$(this).addClass('active');
				}
			});
		},
		highlightQuery: function(data) {
			var elem = this.$elem;
			var searchQuery = new RegExp( '(' +elem.val()+ ')', 'gi' );
			$(''+this.options.resultContainer+'').find('.jxsearch-row div div div, .jxsearch-row span').each(function() {
				$(this).html($(this).text().replace(searchQuery, '<strong class="highlight">$&</strong>'));
			});
		},
		addShowAll: function(total, hidden) {
			return '<div class="jxsearch-alllink"><a href="#">'+jxsearch_showall_text.replace(/%s/g, hidden)+'</a></div>';
		},
		showAllResult: function(link) {
			$(''+this.options.resultContainer+'').find('.jxsearch-row').each(function() {
				$(this).removeClass('hidden-row');
			});
			$(''+this.options.resultContainer+'').find('.search-page').each(function() {
				$(this).removeClass('hidden-page');
			});
			$(''+this.options.resultContainer+'').find('.navigation, .pagers').remove()
			link.remove();
		},
    jxsearchToggle: function() {
      let self = this,
				searchInput = $("#jx_search_query"),
        searchWrapper = $('#jxsearchblock').parent();
      $('#jxsearch-close').on("click", function() {
        searchWrapper.removeClass("active");
        searchInput.val('');
        self.stopJxSearchQueries();
        self.closeJxSearchResult();
      });
      $(document).mouseup(function(e) {
        if (searchWrapper.has(e.target).length === 0 && !searchInput.val()) {
          searchWrapper.removeClass("active");
          self.stopJxSearchQueries();
          self.closeJxSearchResult();
        }
      });
    }
	};

	$.fn.jxPsSearch = function (options) {
		return this.each(function () {
			var search = Object.create(jxPrestashopSearch);
			search.init(options, this);
			$.data(this, 'jxPsSearch', search);
		});
	};

	$.fn.jxPsSearch.options = {
		jxajaxsearchurl: search_url_local,
		jxajaxsearch : use_jx_ajax_search ? use_jx_ajax_search : false,
		categorySelector : 'select[name="search_categories"]',
		resultContainer : '#jxsearch_result',
		resultContainerId : 'jxsearch_result',
		minQeuryLength : jxsearch_minlength ? jxsearch_minlength : 3,
		showAllResults : jxsearch_showallresults ? jxsearch_showallresults : false,
		pagerMode: jxsearch_pager ? jxsearch_pager : false,
		itemsToShow: jxsearch_itemstoshow ? jxsearch_itemstoshow : 3,
		navigationMode: jxsearch_navigation ? jxsearch_navigation : false,
		navigationPosition: jxsearch_navigation_position ? jxsearch_navigation_position : 'both',
		resultHighlight: jxsearch_highlight ? jxsearch_highlight : false
	};
})(jQuery, window, document);

$(document).ready(function() {
	$('#jx_search_query').jxPsSearch();
	if (use_blog_search) {
		$('#jx_blog_search_query').jxPsSearch({
			jxajaxsearchurl: blog_search_url,
			categorySelector  : 'select[name="search_blog_categories"]',
			resultContainer   : '#jxsearch_blog_result',
			resultContainerId : 'jxsearch_blog_result'
		});
	}
  $('#jxsearch-toggle').on("click", function() {
    $('#jxsearchblock').parent().toggleClass("active");
    setTimeout(function() {
      $("#jx_search_query").trigger("focus");
    }, 500);
  });
});
