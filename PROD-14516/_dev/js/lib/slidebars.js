/*!
 * Slidebars - A jQuery Framework for off-canvas Menus and Sidebars
 * Version: 2.0.2
 * Url: http://www.adchsm.com/slidebars/
 * Author: Adam Charles Smith
 * Author url: http://www.adchsm.com/
 * License: MIT
 * License url: http://www.adchsm.com/slidebars/license/
 */

var slidebars = function () {

    /**
     * Setup
     */

    // Cache all canvas elements
    var canvas = $( '[data-canvas]' ),

    // Object of Slidebars
      offCanvas = {},

    // Variables, permitted sides and styles
      init = false,
      registered = false,
      sides = [ 'top', 'right', 'bottom', 'left' ],
      styles = [ 'reveal', 'push', 'overlay', 'shift' ],

      /**
       * Get Animation Properties
       */

      getAnimationProperties = function ( id ) {
          // Variables
          var elements = $(),
            amount = '0',
            duration = parseFloat( offCanvas[ id ].element.css( 'transitionDuration' ), 10 ) * 1000;

          // Elements to animate
          if ( offCanvas[ id ].style === 'reveal' || offCanvas[ id ].style === 'push' || offCanvas[ id ].style === 'shift' ) {
              elements = elements.add( canvas );
          }

          if ( offCanvas[ id ].style === 'push' || offCanvas[ id ].style === 'overlay' || offCanvas[ id ].style === 'shift' ) {
              elements = elements.add( offCanvas[ id ].element );
          }

          if ( $('[data-id-slidebar="' + id + '"]').hasClass('slidebar-toggle-animated') && (offCanvas[ id ].style === 'push' || offCanvas[ id ].style === 'overlay' || offCanvas[ id ].style === 'shift')) {
              elements = elements.add( $('[data-id-slidebar="' + id + '"]') );
          }

          // Amount to animate
          if ( offCanvas[ id ].active ) {
              if ( offCanvas[ id ].side === 'top' ) {
                  amount = offCanvas[ id ].element.css( 'height' ) + ' 0 -' + offCanvas[ id ].element.css( 'height' );
              } else if ( offCanvas[ id ].side === 'right' ) {
                  amount = '0 0 0 -' + offCanvas[ id ].element.css( 'width' );
              } else if ( offCanvas[ id ].side === 'bottom' ) {
                  amount = '-' + offCanvas[ id ].element.css( 'height' ) + ' 0 0';
              } else if ( offCanvas[ id ].side === 'left' ) {
                  amount = '0 -' + offCanvas[ id ].element.css( 'width' ) + ' 0 ' + offCanvas[ id ].element.css( 'width' );
              }
          }

          // Return animation properties
          return { 'elements': elements, 'amount': amount, 'duration': duration };
      },

      /**
       * Slidebars Registration
       */

      registerSlidebar = function ( id, side, style, element ) {
          // Check if Slidebar is registered
          if ( isRegisteredSlidebar( id ) ) {
              throw "Error registering Slidebar, a Slidebar with id '" + id + "' already exists.";
          }

          // Register the Slidebar
          offCanvas[ id ] = {
              'id': id,
              'side': side,
              'style': style,
              'element': element,
              'active': false
          };
      },

      isRegisteredSlidebar = function ( id ) {
          // Return if Slidebar is registered
          if ( offCanvas.hasOwnProperty( id ) ) {
              return true;
          } else {
              return false;
          }
      };

    /**
     * Initialization
     */

    this.init = function ( callback ) {
        // Check if Slidebars has been initialized
        if ( init ) {
            throw "Slidebars has already been initialized.";
        }

        // Loop through and register Slidebars
        if ( ! registered ) {
            $( '[data-off-canvas]' ).each( function () {
                // Get Slidebar parameters
                var parameters = $( this ).attr( 'data-off-canvas' ).split( ' ', 3 );

                // Make sure a valid id, side and style are specified
                if ( ! parameters || ! parameters[ 0 ] || sides.indexOf( parameters[ 1 ] ) === -1 || styles.indexOf( parameters[ 2 ] ) === -1 ) {
                    throw "Error registering Slidebar, please specifiy a valid id, side and style'.";
                }

                // Register Slidebar
                registerSlidebar( parameters[ 0 ], parameters[ 1 ], parameters[ 2 ], $( this ) );
            } );

            // Set registered variable
            registered = true;
        }

        // Set initialized variable
        init = true;

        // Set CSS
        this.css();

        // Trigger event
        $( events ).trigger( 'init' );

        // Run callback
        if ( typeof callback === 'function' ) {
            callback();
        }
    };

    this.exit = function ( callback ) {
        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Exit
        var exit = function () {
            // Set init variable
            init = false;

            // Trigger event
            $( events ).trigger( 'exit' );

            // Run callback
            if ( typeof callback === 'function' ) {
                callback();
            }
        };

        // Call exit, close open Slidebar if active
        if ( this.getActiveSlidebar() ) {
            this.close( exit );
        } else {
            exit();
        }
    };

    /**
     * CSS
     */

    this.css = function ( callback ) {
        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Reposition open Slidebars
        if ( this.getActiveSlidebar() ) {
            this.open( this.getActiveSlidebar() );
        }

        // Trigger event
        $( events ).trigger( 'css' );

        // Run callback
        if ( typeof callback === 'function' ) {
            callback();
        }
    };

    /**
     * Controls
     */

    this.open = function ( id, callback ) {
        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Check if id wasn't passed
        if ( ! id ) {
            throw "You must pass a Slidebar id.";
        }

        // Check if Slidebar is registered
        if ( ! isRegisteredSlidebar( id ) ) {
            throw "Error opening Slidebar, there is no Slidebar with id '" + id + "'.";
        }

        // Open
        var open = function () {
            // Set active state to true
            offCanvas[ id ].active = true;

            // Display the Slidebar
            offCanvas[ id ].element.css( 'visibility', 'visible' );

            // Trigger event
            $( events ).trigger( 'opening', [ offCanvas[ id ].id ] );

            // Get animation properties
            var animationProperties = getAnimationProperties( id );
            // Apply css
            $('html').addClass('slidebar-active-wrapper');
            animationProperties.elements.css( {
                'transition-duration': animationProperties.duration + 'ms',
                'margin': animationProperties.amount
            } ).addClass('open-slidebar');

            // Transition completed
            setTimeout( function () {
                // Trigger event
                $( events ).trigger( 'opened', [ offCanvas[ id ].id ] );

                // Run callback
                if ( typeof callback === 'function' ) {
                    callback();
                }
            }, animationProperties.duration );
        };

        // Call open, close open Slidebar if active
        if ( this.getActiveSlidebar() && this.getActiveSlidebar() !== id ) {
            this.close( open );
        } else {
            open();
        }
    };

    this.close = function ( id, callback ) {
        // Shift callback arguments
        if ( typeof id === 'function' ) {
            callback = id;
            id = null;
        }

        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Check if id was passed but isn't a registered Slidebar
        if ( id && ! isRegisteredSlidebar( id ) ) {
            throw "Error closing Slidebar, there is no Slidebar with id '" + id + "'.";
        }

        // If no id was passed, get the active Slidebar
        if ( ! id ) {
            id = this.getActiveSlidebar();
        }

        // Close a Slidebar
        if ( id && offCanvas[ id ].active ) {
            // Set active state to false
            offCanvas[ id ].active = false;

            // Trigger event
            $( events ).trigger( 'closing', [ offCanvas[ id ].id ] );

            // Get animation properties
            var animationProperties = getAnimationProperties( id );

            // Apply css
            animationProperties.elements.css( 'margin', '' ).removeClass('open-slidebar');
            setTimeout( function () {
                $('html').removeClass('slidebar-active-wrapper');
            }, animationProperties.duration );
            // Transition completetion
            setTimeout( function () {
                // Remove transition duration
                animationProperties.elements.css( 'transition-duration', '' );

                // Hide the Slidebar
                offCanvas[ id ].element.css( 'visibility', '' );

                // Trigger event
                $( events ).trigger( 'closed', [ offCanvas[ id ].id ] );

                // Run callback
                if ( typeof callback === 'function' ) {
                    callback();
                }
            }, animationProperties.duration );
        }
    };

    this.toggle = function ( id, callback ) {
        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Check if id wasn't passed
        if ( ! id ) {
            throw "You must pass a Slidebar id.";
        }

        // Check if Slidebar is registered
        if ( ! isRegisteredSlidebar( id ) ) {
            throw "Error toggling Slidebar, there is no Slidebar with id '" + id + "'.";
        }

        // Check Slidebar state
        if ( offCanvas[ id ].active ) {
            // It's open, close it
            this.close( id, function () {
                // Run callback
                if ( typeof callback === 'function' ) {
                    callback();
                }
            } );
        } else {
            // It's closed, open it
            this.open( id, function () {
                // Run callback
                if ( typeof callback === 'function' ) {
                    callback();
                }
            } );
        }
    };

    /**
     * Active States
     */

    this.isActive = function () {
        // Return init state
        return init;
    };

    this.isActiveSlidebar = function ( id ) {
        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Check if id wasn't passed
        if ( ! id ) {
            throw "You must provide a Slidebar id.";
        }

        // Check if Slidebar is registered
        if ( ! isRegisteredSlidebar( id ) ) {
            throw "Error retrieving Slidebar, there is no Slidebar with id '" + id + "'.";
        }

        // Return the active state
        return offCanvas[ id ].active;
    };

    this.getActiveSlidebar = function () {
        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Variable to return
        var active = false;

        // Loop through Slidebars
        for ( var id in offCanvas ) {
            // Check if Slidebar is registered
            if ( isRegisteredSlidebar( id ) ) {
                // Check if it's active
                if ( offCanvas[ id ].active ) {
                    // Set the active id
                    active = offCanvas[ id ].id;
                    break;
                }
            }
        }

        // Return
        return active;
    };

    this.getSlidebars = function () {
        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Create an array for the Slidebars
        var slidebarsArray = [];

        // Loop through Slidebars
        for ( var id in offCanvas ) {
            // Check if Slidebar is registered
            if ( isRegisteredSlidebar( id ) ) {
                // Add Slidebar id to array
                slidebarsArray.push( offCanvas[ id ].id );
            }
        }

        // Return
        return slidebarsArray;
    };

    this.getSlidebar = function ( id ) {
        // Check if Slidebars has been initialized
        if ( ! init ) {
            throw "Slidebars hasn't been initialized.";
        }

        // Check if id wasn't passed
        if ( ! id ) {
            throw "You must pass a Slidebar id.";
        }

        // Check if Slidebar is registered
        if ( ! isRegisteredSlidebar( id ) ) {
            throw "Error retrieving Slidebar, there is no Slidebar with id '" + id + "'.";
        }

        // Return the Slidebar's properties
        return offCanvas[ id ];
    };

    /**
     * Events
     */

    this.events = {};
    var events = this.events;

    /**
     * Resizes
     */

    $( window ).on( 'resize', this.css.bind( this ) );
};

// Clone slidebars toggle
$('.clone-slidebar-toggle').each(function () {
    $('body').append('<span id="' + $(this).attr('data-id-slidebar') + '" class="slidebar-toggle" data-id-slidebar="' + $(this).attr('data-id-slidebar') + '"></span>');
});

$(document).on('click', '.clone-slidebar-toggle', function (event) {
    event.preventDefault();
    $('#' + $(this).attr('data-id-slidebar')).trigger('click');
});


var controller = new slidebars();
controller.init();

$('.slidebar-toggle').each(function () {
    var idSlidebar = $(this).attr('data-id-slidebar');
    $(this).on( 'click', function ( event ) {
        if (!$(this).hasClass('inactive-device')) {
            event.stopPropagation();
            event.preventDefault();
            controller.toggle(idSlidebar);
            $(this).toggleClass('active-sl-toogle');
        }
    });
});
// Close any
$( document ).on( 'click', '.js-close-any', function ( event ) {
    if ( controller.getActiveSlidebar() && !$( event.target ).closest('[data-off-canvas]').hasClass('open-slidebar') ) {
        event.preventDefault();
        event.stopPropagation();
        controller.close();
        $('.slidebar-toggle').removeClass('active-sl-toogle');
    }
} );

// Close Slidebar links
$( '[data-off-canvas] button.closeSlidebar' ).on( 'click', function ( event ) {
    event.preventDefault();
    event.stopPropagation();
    controller.close();
} );

// Add close class to canvas container when Slidebar is opened
$( controller.events ).on( 'opening', function () {
    $( '[data-canvas]' ).addClass( 'js-close-any' );
} );

// Add close class to canvas container when Slidebar is opened
$( controller.events ).on( 'closing', function () {
    $( '[data-canvas]' ).removeClass( 'js-close-any' );
} );