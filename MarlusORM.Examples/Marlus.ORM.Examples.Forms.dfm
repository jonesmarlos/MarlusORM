object fmMarlusORMExamples: TfmMarlusORMExamples
  Left = 0
  Top = 0
  Caption = 'Examples'
  ClientHeight = 456
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    800
    456)
  PixelsPerInch = 96
  TextHeight = 13
  object mmSQL: TMemo
    Left = 8
    Top = 8
    Width = 648
    Height = 440
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    ExplicitHeight = 448
  end
  object btSelectAll: TButton
    Left = 664
    Top = 8
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Select All'
    TabOrder = 1
    OnClick = btSelectAllClick
  end
  object btSelectRecord: TButton
    Left = 664
    Top = 40
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Select Record'
    TabOrder = 2
    OnClick = btSelectRecordClick
  end
  object btSelectCriteria: TButton
    Left = 664
    Top = 72
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Select Criteria'
    TabOrder = 3
    OnClick = btSelectCriteriaClick
  end
  object btUpdateAll: TButton
    Left = 664
    Top = 112
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Update All'
    TabOrder = 4
  end
  object btUpdateRecord: TButton
    Left = 664
    Top = 144
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Update Record'
    TabOrder = 5
  end
  object btUpdateCriteria: TButton
    Left = 664
    Top = 176
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Update Criteria'
    TabOrder = 6
  end
  object btDeleteAll: TButton
    Left = 664
    Top = 248
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete All'
    TabOrder = 7
  end
  object btDeleteRecord: TButton
    Left = 664
    Top = 280
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete Record'
    TabOrder = 8
  end
  object btDeleteCriteria: TButton
    Left = 664
    Top = 312
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete Criteria'
    TabOrder = 9
  end
  object btInsertRecord: TButton
    Left = 664
    Top = 352
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Insert Record'
    TabOrder = 10
  end
  object btInsertOrUpdate: TButton
    Left = 664
    Top = 424
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Insert or Update'
    TabOrder = 11
  end
  object btUpdateTemplate: TButton
    Left = 664
    Top = 208
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Update Template'
    TabOrder = 12
  end
  object btInsertTemplate: TButton
    Left = 664
    Top = 384
    Width = 128
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Insert Template'
    TabOrder = 13
  end
end
