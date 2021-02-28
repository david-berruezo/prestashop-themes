<?php

class customFeatured extends ObjectModel
{
  public $id_customfeatured;
  public $active = 1;
  public $type;
  public $position;
  public $ids_products;
  public $ids_categories;
  public $date_add;
  public $title;

  public static $definition = array(
    'table' => 'customfeatured',
    'primary' => 'id_customfeatured',
    'multilang' => true,
    'multilang_shop' => true,
    'fields' => array(
      //basic fields

      'active' => 		array('type' => self::TYPE_BOOL,'validate' => 'isBool'),
      'type' =>			array('type' => self::TYPE_STRING,  'validate' => 'isCleanHtml'),
      'position' => 	array('type' => self::TYPE_INT, 'validate' => 'isunsignedInt'),
      'ids_products' =>			array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'),
      'ids_categories' =>			array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'),
      'date_add' =>            array('type' => self::TYPE_DATE, 'validate' => 'isDate'),

      // Lang fields

      'title' =>			array('type' => self::TYPE_STRING, 'lang' => true, 'required' => true, 'validate' => 'isCleanHtml',  'size' => 255),
    )
  );

  public function __construct($id_customfeatured = null, $id_lang = null, $id_shop = null)
  {

    parent::__construct($id_customfeatured, $id_lang, $id_shop);
    Shop::addTableAssociation('customfeatured_lang', array('type' => 'fk_shop'));
  }

  public function update($null_values = false)
  {
    $statusmpm_homefeatured = Tools::getValue('statuscustomfeatured');
    if(!$statusmpm_homefeatured && ($statusmpm_homefeatured !== "")){
      $idsProducts = Tools::getValue('idsProducts');
      $idsCategories = Tools::getValue('categoryBox');
      if($idsCategories){
        $idsCategories = implode(",", $idsCategories);
        $this->ids_categories = $idsCategories;
      }
      else{
        $this->ids_categories = '';
      }

      $this->ids_products = $idsProducts;
    }
    $res = parent::update($null_values);
    return $res;
  }

  public function delete()
  {
    $res = parent::delete();
    return $res;
  }

  public function add($autodate = true, $null_values = false)
  {
    $idsProducts = Tools::getValue('idsProducts');
    $idsCategories = Tools::getValue('categoryBox');
    if($idsCategories){
      $idsCategories = implode(",", $idsCategories);
      $this->ids_categories = $idsCategories;
    }
    else{
      $this->ids_categories = '';
    }
    $this->ids_products = $idsProducts;


    $position = (int)$this->getLastSlidesPosition() + 1;
    $this->position = $position;



    $res = parent::add($autodate, $null_values);
    return $res;
  }


  public function getLastSlidesPosition()
  {
    return (int)(Db::getInstance()->getValue('
		SELECT MAX(s.`position`)
		FROM `'._DB_PREFIX_.'customfeatured` s
		') );
  }


  public function getSetiingsItem($id_lang, $id_shop, $id){

    $where ='';

    if($id){
      $where = ' AND h.id_customfeatured ='.(int)$id;
    }

    $sql = '
			SELECT *
      FROM ' . _DB_PREFIX_ . 'customfeatured as h
      INNER JOIN ' . _DB_PREFIX_ . 'customfeatured_lang as hl
      ON h.id_customfeatured = hl.id_customfeatured
      WHERE hl.id_lang = ' . (int)$id_lang . '
      AND hl.id_shop = ' . (int)$id_shop .'
      AND h.active = 1
      '.$where.'
      ORDER BY h.position
			';

    return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
  }


}