# encoding: utf-8

require 'test_helper'

class HtmlSnapshotTest < ActiveSupport::TestCase
  test "should extract links" do
    doc   = Nokogiri::HTML(load_html)
    links = doc.css('a')
    hrefs = links.map { |link| link.attribute('href').to_s }.uniq.sort.delete_if { |href| href.empty? }
    assert links.count.eql?(18), "parser doesn't detect all links"
    assert hrefs.count.eql?(17), "parser doesn't extract all href"
  end

  test "should replace paths" do
    base_url  = 'http://www.weprod.fr'
    page_url  = 'http://www.weprod.fr/biotherm/2012/beauty-from-the-deep/en-GB'
    base_path = '/biotherm/2012/beauty-from-the-deep'.split('/').delete_if { |part| part.empty? }
    path      = 'en-GB'

    base    = [ 'biotherm', '2012', 'beauty-from-the-deep' ]
    current = [ 'en-GB' ]


    doc   = Nokogiri::HTML(load_html)

    links = doc.css('a')
    hrefs = links.map { |link| link.attribute('href').to_s }.uniq.sort.delete_if { |href| href.empty? }

    final = {}

    hrefs.each_with_index do |href, i|
      original = href
      href     = href.split('/').delete_if { |part| part.empty? }
      href.each_with_index do |part, index|
        next if index.eql? 0
        unless base[index].eql? part
          href = href.drop(index)
          break
        end
      end

      href.each_with_index do |part, index|
        unless current[index].eql? part
          if index.eql? 0
            href = href.reverse.push('..').reverse
          end
          href = href.drop(index)
          break
        end
      end
      final[original] = href.join('/')
    end

    links.each do |link|
      link.set_attribute('href', final[link.attribute('href').text])
    end

    assert doc.eql?(Nokogiri::HTML(load_export)), "parser doesn't replace path correctly"
  end

  private

  def load_html

    "<!DOCTYPE html>
<head>
    <title>Beauty from the deep</title>
    <meta charset='utf-8' />
    <meta name='author' content='Semio Design' />
    <meta name='viewport' content='width=device-width' />

    <link href='/assets/favicon.png' rel='shortcut icon' type='image/png' />
    <link href='/assets/favicon_129x129.png' rel='apple-touch-icon' type='image/png' />
    <link href='/assets/favicon_72x72.png' rel='apple-touch-icon' sizes='72x72' type='image/png' />
    <link href='/assets/favicon_114x114.png' rel='apple-touch-icon' sizes='114x114' type='image/png' />

    <!--
    <link rel='stylesheet' href='/weprod/deps/midgard-notifications/midgardnotif.css' media='screen' />
    -->

    <link href='/assets/deps.css?body=1' media='screen' rel='stylesheet' type='text/css' />
<link href='/assets/font-awesome.css?body=1' media='screen' rel='stylesheet' type='text/css' />
    <link href='/assets/create-js.css?body=1' media='screen' rel='stylesheet' type='text/css' />
<link href='/assets/create-ui.css?body=1' media='screen' rel='stylesheet' type='text/css' />
    <link href='/assets/biotherm.css?body=1' media='screen' rel='stylesheet' type='text/css' />

    

    <script src='/assets/jquery.js?body=1' type='text/javascript'></script>
<script src='/assets/weprod/projects.js?body=1' type='text/javascript'></script>
<script src='/assets/weprod/script.js?body=1' type='text/javascript'></script>
<script src='/assets/weprod.js?body=1' type='text/javascript'></script>
    <script src='/assets/deps/jquery/jquery-1.7.2.min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/jquery/jquery-ui-1.8.21.custom.min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/modernizr/modernizr-2.5.3-respond-1.1.0.min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/underscore/underscore-min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/backbone/backbone-min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/vie/vie-min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/rangy/rangy-core-1.2.3.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/hallo/hallo-min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/create/create.js?body=1' type='text/javascript'></script>
<script src='/assets/deps.js?body=1' type='text/javascript'></script>
    <script src='/assets/biotherm/2012/beauty-from-the-deep/js/jquery.waterwheelCarousel.js?body=1' type='text/javascript'></script>
<script src='/assets/biotherm/2012/beauty-from-the-deep/js/video-js/video.min.js?body=1' type='text/javascript'></script>
<script src='/assets/biotherm.js?body=1' type='text/javascript'></script>

    <meta content='authenticity_token' name='csrf-param' />
<meta content='qvKTvZgkDpOh46T1eKo6rnCrRxMjDWgkfERvZAKxcRE=' name='csrf-token' />

    <script>
        jQuery(document).ready(function ($) {
            $('body').midgardCreate({
                url: function () { return '/documents/update/key/9fabe35072ab51da4ad53aba8dda31aa490453c0/language/en/'; },
                highlight: false,
                editorWidgets: {
                    default: 'hallo'
                },
                editorOptions: {
                    hallo: {
                        widget: 'halloWidget',
                        options: {
                            plugins: {
                                halloformat: {}
                            }
                        }
                    }
                }
            });
      });
    </script>

</head>
    <body class='template-index page-1'>
        <div id='wrapper'>
            <div id='wrapper-inner'>
                <article xmlns:sioc='http://rdfs.org/sioc/ns#'
                         xmlns:dcterms='http://purl.org/dc/terms/'
                         typeof='sioc:Post'
                         class='container'
                         about='http://semiodev:3000/biotherm/2012/en/'>
                    <header>
                        <div id='header-inner'>
                            <p property='overTitle'>Discover</p>
                            <h1><span property='dcterms:title'><b>Beauty from the deep</b></span></h1>
                            <h2 property='dcterms:alternative'></h2>
                        </div>
                        <nav>
                            <ul>
                                <li class='active'>
                                    <a href='/biotherm/2012/beauty-from-the-deep/en-GB'>Beauty from the deep</a>
                                </li>
                                <li class=''>
                                    <a href='/biotherm/2012/beauty-from-the-deep/en-GB/history'>Our history</a>
                                </li>
                                <li class=''>
                                    <a href='/biotherm/2012/beauty-from-the-deep/en-GB/expertise'>Our expertise</a>
                                </li>
                                <li class=''>
                                    <a href='/biotherm/2012/beauty-from-the-deep/en-GB/philosophy'>Our philosophy</a>
                                </li>
                                <li class=''>
                                    <a href='/biotherm/2012/beauty-from-the-deep/en-GB/iconic-products'>Iconic products</a>
                                </li>
                                <li class=''>
                                    <a href='/biotherm/2012/beauty-from-the-deep/en-GB/new-products'>New products</a>
                                </li>
                                <li class=''>
                                    <a href='/biotherm/2012/beauty-from-the-deep/en-GB/to-our-customers'>To our customers</a>
                                </li>
                                <li class=''>
                                    <a href='/biotherm/2012/beauty-from-the-deep/en-GB/quiz'>Take The Quiz</a>
                                </li>
                            </ul>
                        </nav>
                    </header>
                    <div id='page'>
                        <div id='page-inner' class=''>

                            <section property='dcterms:content'>
    <p>Billions of years ago life on the planet started in water. The first living organisms were plankton. Still today water is the source of life. The ocean is part of modern man- and womankind. We are made 70% of saline water as is our skin.</p><p>Biologically, our skin composition has more in common with aquatic organisms than terrestrial plants. Plankton, micro algae and algae share specific biological characteristics with human skin. These characteristics have survived throughout evolution proving how essential they are. Like skin, these aquatic organisms have developed specific defense mechanisms to resist against external aggressions and dehydration as well as the ability to auto-regenerate. With their similarities to and affinity with the skin, aquatic molecules are powerful actives in skin biology: regeneration, repair, protection.</p><p>Until now, aquatic ingredients were harvested and hard to resource. Blue Biotechnology is a new Science converging sustainable innovations and actives from aquatic resources. With Pure Thermal Plankton, Biotherm has 20 years of expertise in Blue Biotechnology with unique sustainable processes of selection: fermentation, extraction and cell engineering.</p><p>“SYMBIOTIC BEAUTY”</p><p>Exceptional aquatic ingredients that work in symbiosis with the skin. Sustainable beauty for lasting healthy radiant skin.</p>
</section>

                        </div>

                            <nav class='linear'>

                            <a href='http://www.weprod.fr/biotherm/2012/beauty-from-the-deep/en-GB/history' class='next'>Next page</a>
                            </nav>
                    </div>

                    <div class='languages'>
                        <ul>
                            <li class='active'>
                                <a href='/biotherm/2012/beauty-from-the-deep/en-GB'>English</a>
                            </li>
                            <li class=''>
                                <a href='/biotherm/2012/beauty-from-the-deep/fr-FR'>French</a>
                            </li>
                            <li class=''>
                                <a href='/biotherm/2012/beauty-from-the-deep/de-DE'>Deutsch</a>
                            </li>
                            <li class=''>
                                <a href='/biotherm/2012/beauty-from-the-deep/tr-TR'>Türkçe</a>
                            </li>
                            <li class=''>
                                <a href='/biotherm/2012/beauty-from-the-deep/ko-KO'>한국의</a>
                            </li>
                            <li class=''>
                                <a href='/biotherm/2012/beauty-from-the-deep/ru-RU'>русский</a>
                            </li>
                            <li class=''>
                                <a href='/biotherm/2012/beauty-from-the-deep/es-ES'>Español</a>
                            </li>
                            <li class=''>
                                <a href='/biotherm/2012/beauty-from-the-deep/zh-ZH'>中国的</a>
                            </li>
                            <li class=''>
                                <a href='/biotherm/2012/beauty-from-the-deep/fi-FI'>suomi</a>
                            </li>
                        </ul>
                    </div>
                </article>
                <footer class='logo'>
                    
                </footer>
            </div>
        </div>
    </body>
</html>"

  end
  def load_export

    "<!DOCTYPE html>
<head>
    <title>Beauty from the deep</title>
    <meta charset='utf-8' />
    <meta name='author' content='Semio Design' />
    <meta name='viewport' content='width=device-width' />

    <link href='/assets/favicon.png' rel='shortcut icon' type='image/png' />
    <link href='/assets/favicon_129x129.png' rel='apple-touch-icon' type='image/png' />
    <link href='/assets/favicon_72x72.png' rel='apple-touch-icon' sizes='72x72' type='image/png' />
    <link href='/assets/favicon_114x114.png' rel='apple-touch-icon' sizes='114x114' type='image/png' />

    <!--
    <link rel='stylesheet' href='/weprod/deps/midgard-notifications/midgardnotif.css' media='screen' />
    -->

    <link href='/assets/deps.css?body=1' media='screen' rel='stylesheet' type='text/css' />
<link href='/assets/font-awesome.css?body=1' media='screen' rel='stylesheet' type='text/css' />
    <link href='/assets/create-js.css?body=1' media='screen' rel='stylesheet' type='text/css' />
<link href='/assets/create-ui.css?body=1' media='screen' rel='stylesheet' type='text/css' />
    <link href='/assets/biotherm.css?body=1' media='screen' rel='stylesheet' type='text/css' />

    

    <script src='/assets/jquery.js?body=1' type='text/javascript'></script>
<script src='/assets/weprod/projects.js?body=1' type='text/javascript'></script>
<script src='/assets/weprod/script.js?body=1' type='text/javascript'></script>
<script src='/assets/weprod.js?body=1' type='text/javascript'></script>
    <script src='/assets/deps/jquery/jquery-1.7.2.min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/jquery/jquery-ui-1.8.21.custom.min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/modernizr/modernizr-2.5.3-respond-1.1.0.min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/underscore/underscore-min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/backbone/backbone-min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/vie/vie-min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/rangy/rangy-core-1.2.3.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/hallo/hallo-min.js?body=1' type='text/javascript'></script>
<script src='/assets/deps/create/create.js?body=1' type='text/javascript'></script>
<script src='/assets/deps.js?body=1' type='text/javascript'></script>
    <script src='/assets/biotherm/2012/beauty-from-the-deep/js/jquery.waterwheelCarousel.js?body=1' type='text/javascript'></script>
<script src='/assets/biotherm/2012/beauty-from-the-deep/js/video-js/video.min.js?body=1' type='text/javascript'></script>
<script src='/assets/biotherm.js?body=1' type='text/javascript'></script>

    <meta content='authenticity_token' name='csrf-param' />
<meta content='qvKTvZgkDpOh46T1eKo6rnCrRxMjDWgkfERvZAKxcRE=' name='csrf-token' />

    <script>
        jQuery(document).ready(function ($) {
            $('body').midgardCreate({
                url: function () { return '/documents/update/key/9fabe35072ab51da4ad53aba8dda31aa490453c0/language/en/'; },
                highlight: false,
                editorWidgets: {
                    default: 'hallo'
                },
                editorOptions: {
                    hallo: {
                        widget: 'halloWidget',
                        options: {
                            plugins: {
                                halloformat: {}
                            }
                        }
                    }
                }
            });
      });
    </script>

</head>
    <body class='template-index page-1'>
        <div id='wrapper'>
            <div id='wrapper-inner'>
                <article xmlns:sioc='http://rdfs.org/sioc/ns#'
                         xmlns:dcterms='http://purl.org/dc/terms/'
                         typeof='sioc:Post'
                         class='container'
                         about='http://semiodev:3000/biotherm/2012/en/'>
                    <header>
                        <div id='header-inner'>
                            <p property='overTitle'>Discover</p>
                            <h1><span property='dcterms:title'><b>Beauty from the deep</b></span></h1>
                            <h2 property='dcterms:alternative'></h2>
                        </div>
                        <nav>
                            <ul>
                                <li class='active'>
                                    <a href=''>Beauty from the deep</a>
                                </li>
                                <li class=''>
                                    <a href='history'>Our history</a>
                                </li>
                                <li class=''>
                                    <a href='expertise'>Our expertise</a>
                                </li>
                                <li class=''>
                                    <a href='philosophy'>Our philosophy</a>
                                </li>
                                <li class=''>
                                    <a href='iconic-products'>Iconic products</a>
                                </li>
                                <li class=''>
                                    <a href='new-products'>New products</a>
                                </li>
                                <li class=''>
                                    <a href='to-our-customers'>To our customers</a>
                                </li>
                                <li class=''>
                                    <a href='quiz'>Take The Quiz</a>
                                </li>
                            </ul>
                        </nav>
                    </header>
                    <div id='page'>
                        <div id='page-inner' class=''>

                            <section property='dcterms:content'>
    <p>Billions of years ago life on the planet started in water. The first living organisms were plankton. Still today water is the source of life. The ocean is part of modern man- and womankind. We are made 70% of saline water as is our skin.</p><p>Biologically, our skin composition has more in common with aquatic organisms than terrestrial plants. Plankton, micro algae and algae share specific biological characteristics with human skin. These characteristics have survived throughout evolution proving how essential they are. Like skin, these aquatic organisms have developed specific defense mechanisms to resist against external aggressions and dehydration as well as the ability to auto-regenerate. With their similarities to and affinity with the skin, aquatic molecules are powerful actives in skin biology: regeneration, repair, protection.</p><p>Until now, aquatic ingredients were harvested and hard to resource. Blue Biotechnology is a new Science converging sustainable innovations and actives from aquatic resources. With Pure Thermal Plankton, Biotherm has 20 years of expertise in Blue Biotechnology with unique sustainable processes of selection: fermentation, extraction and cell engineering.</p><p>“SYMBIOTIC BEAUTY”</p><p>Exceptional aquatic ingredients that work in symbiosis with the skin. Sustainable beauty for lasting healthy radiant skin.</p>
</section>

                        </div>

                            <nav class='linear'>

                            <a href='history' class='next'>Next page</a>
                            </nav>
                    </div>

                    <div class='languages'>
                        <ul>
                            <li class='active'>
                                <a href='/'>English</a>
                            </li>
                            <li class=''>
                                <a href='../fr-FR'>French</a>
                            </li>
                            <li class=''>
                                <a href='../de-DE'>Deutsch</a>
                            </li>
                            <li class=''>
                                <a href='../tr-TR'>Türkçe</a>
                            </li>
                            <li class=''>
                                <a href='../ko-KO'>한국의</a>
                            </li>
                            <li class=''>
                                <a href='../ru-RU'>русский</a>
                            </li>
                            <li class=''>
                                <a href='../es-ES'>Español</a>
                            </li>
                            <li class=''>
                                <a href='../zh-ZH'>中国的</a>
                            </li>
                            <li class=''>
                                <a href='../fi-FI'>suomi</a>
                            </li>
                        </ul>
                    </div>
                </article>
                <footer class='logo'>
                    
                </footer>
            </div>
        </div>
    </body>
</html>"

  end
end
