<?php
/*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_')) {
  exit;
}


class mpm_imageslist extends Module
{
  private $templateFile;

  public function __construct()
  {
    $this->name = 'mpm_imageslist';
    $this->version = '1.0.0';
    $this->author = 'PrestaShop';
    $this->need_instance = 0;
    $this->tab = 'front_office_features';
    $this->bootstrap = true;
    parent::__construct();

    $this->displayName = $this->l('View product images');
    $this->description = $this->l('View product images.');

    $this->ps_versions_compliancy = array('min' => '1.7.0.0', 'max' => _PS_VERSION_);

    $this->templateFile = 'module:mpm_imageslist/views/templates/hook/list.tpl';

  }

  public function install()
  {
    return (parent::install() &&
      $this->registerHook('displayHeader') &&
      $this->registerHook('displayImagesList')
    );
  }


  public function uninstall()
  {
    return parent::uninstall();
  }


  public function hookDisplayHeader($params)
  {

    $this->context->controller->registerStylesheet('mpm_imageslist', 'modules/'.$this->name.'/views/css/mpm_imageslist.css', array('media' => 'all', 'priority' => 900));
    $this->context->controller->registerJavascript('mpm_imageslist', 'modules/'.$this->name.'/views/js/mpm_imageslist.js',  array('position' => 'bottom', 'priority' => 150));
  }


  public function hookDisplayImagesList($params)
  {

    $product = $params['product'];
    $images = array();
    $ids = $this->getImagesId($product['id_product']);

    if(!$ids){
      return false;
    }

    $obj = new Product($product['id_product'], false, Context::getContext()->language->id);

    $type = ImageType::getFormattedName('home');
    $ids = explode(",", $ids);
    foreach ($ids as $val){
      $images[] = $this->context->link->getImageLink($obj->link_rewrite, $val, $type);
    }

    $count_images = count($images);

    if($count_images<2){
      return false;
    }

    $cover = $product['cover']['bySize'][$type]['url'];

    $this->smarty->assign(
      array(
        'images'       => $images,
        'cover'        => $cover,
        'count_images' => $count_images,
        'id_product'   => $product['id_product'],
      )
    );

    return $this->fetch($this->templateFile);
  }



  public function getImagesId($id_product){

    $sql = '
			SELECT  GROUP_CONCAT( i.id_image ) as ids
      FROM ' . _DB_PREFIX_ . 'image as i
      WHERE i.id_product = ' . (int)$id_product . '
			';

    $res = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);

    if(isset($res[0]['ids']) && $res[0]['ids']){
      return $res[0]['ids'];
    }

    return false;
  }


}
