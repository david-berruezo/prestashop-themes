{**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
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
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2018 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{if $field.type == 'hidden'}

  {block name='form_field_item_hidden'}
    <input type="hidden" name="{$field.name}" value="{$field.value}">
  {/block}

{else}

  <div class="form-group{if !empty($field.errors)} has-error{/if}">
    <div class="form-control-content">

      {if $field.type === 'select'}

        {block name='form_field_item_select'}
          <select class="custom-select" name="{$field.name}" {if $field.required}required{/if}>
            <option value disabled selected>{$field.label}</option>
            {foreach from=$field.availableValues item="label" key="value"}
              <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
            {/foreach}
          </select>
        {/block}

      {elseif $field.type === 'countrySelect'}

        {block name='form_field_item_country'}
          <select
          class="custom-select js-country"
          name="{$field.name}"
          {if $field.required}required{/if}
          >
            <option value disabled selected>{$field.label}</option>
            {foreach from=$field.availableValues item="label" key="value"}
              <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
            {/foreach}
          </select>
        {/block}

      {elseif $field.type === 'radio-buttons'}

        {block name='form_field_item_radio'}
          {foreach from=$field.availableValues item="label" key="value"}
            <div class="custom-control custom-radio {if $field.name == "id_gender"}custom-control-inline{/if}">
              <label>
                <input class="custom-control-input" name="{$field.name}" type="radio" value="{$value}"{if $field.required} required{/if}{if $value eq $field.value} checked{/if}>
                <span class="custom-control-label">{$label}</span>
              </label>
            </div>
          {/foreach}
        {/block}

      {elseif $field.type === 'checkbox'}

        {block name='form_field_item_checkbox'}
          <div class="custom-control custom-checkbox">
            <label>
              <input class="custom-control-input" name="{$field.name}" type="checkbox" value="1"{if $field.value} checked="checked"{/if}{if $field.required} required{/if}>
              <span class="custom-control-label">{$field.label nofilter}</span>
            </label>
          </div>
        {/block}

      {elseif $field.type === 'date'}

        {block name='form_field_item_date'}
          <input name="{$field.name}" class="form-control" type="date" value="{$field.value}" placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{/if}">
          {if isset($field.availableValues.comment)}
            <span class="form-control-comment">
              {$field.availableValues.comment}
            </span>
          {/if}
        {/block}

      {elseif $field.type === 'birthday'}

        {block name='form_field_item_birthday'}
          <div class="js-parent-focus">
            {html_select_date
            field_order=DMY
            time={$field.value}
            field_array={$field.name}
            prefix=false
            reverse_years=true
            field_separator='<br>'
            day_extra='class="custom-select"'
            month_extra='class="custom-select"'
            year_extra='class="custom-select"'
            day_empty={l s='-- day --' d='Shop.Forms.Labels'}
            month_empty={l s='-- month --' d='Shop.Forms.Labels'}
            year_empty={l s='-- year --' d='Shop.Forms.Labels'}
            start_year={'Y'|date}-100 end_year={'Y'|date}
            }
          </div>
        {/block}

      {elseif $field.type === 'password'}

        {block name='form_field_item_password'}
          <div class="input-group input-group-lg">
            <input
              class="form-control js-visible-password"
              name="{$field.name}"
              type="password"
              value=""
              pattern=".{literal}{{/literal}5,{literal}}{/literal}"
              placeholder="{$field.label}"
              {if $field.required}required{/if}
            >
            <div class="input-group-text" data-action="show-password">
              <i class="fa fa-eye" aria-hidden="true"></i>
            </div>
          </div>
        {/block}

      {else}

        {block name='form_field_item_other'}
          <input
            class="form-control form-control-lg"
            name="{$field.name}"
            type="{$field.type}"
            value="{$field.value}"
            placeholder="{$field.label}"
            {if $field.maxLength}maxlength="{$field.maxLength}"{/if}
            {if $field.required}required{/if}
          >
          {if isset($field.availableValues.comment)}
            <span class="form-control-comment">
              {$field.availableValues.comment}
            </span>
          {/if}
        {/block}

      {/if}

      {block name='form_field_errors'}
        {include file='_partials/form-errors.tpl' errors=$field.errors}
      {/block}

    </div>
  </div>

{/if}
